//
//  MCCViewController.m
//  Mobiquity Coding Challenge
//
//  Created by Sydney Richardson on 4/1/14.
//  Copyright (c) 2014 Sydney Richardson. All rights reserved.
//

#import "MCCViewController.h"
#import "MCCTableViewCell.h"
#import "MCCDisplayImageViewController.h"
#import <Dropbox/Dropbox.h>
#import <CoreLocation/CoreLocation.h>

@interface MCCViewController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *linkDropboxButton;
@property (strong, nonatomic) DBAccount *userDBAccount;

@end

@implementation MCCViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"init called");
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userDBAccount = [[DBAccountManager sharedManager] linkedAccount];
    if (self.userDBAccount) {
        DBFilesystem *filesystem = [[DBFilesystem alloc] initWithAccount:self.userDBAccount];
        [DBFilesystem setSharedFilesystem:filesystem];
        [self.linkDropboxButton setEnabled:NO];
        [self.tableView reloadData];
    }
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
}

- (IBAction)linkToDropbox:(id)sender {
    [[DBAccountManager sharedManager] linkFromController:self];
    [self.linkDropboxButton setEnabled:NO];
    [self.linkDropboxButton setBackButtonBackgroundImage:nil
                                                forState:UIControlStateDisabled
                                              barMetrics:UIBarMetricsDefault];
    
    [self.tableView reloadData];
    
}

- (IBAction)didPressCameraButton:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    //if there is a camera, then load it, else load the images.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [imagePicker setDelegate:self];
    
    // Place image picker on the screen
    [self presentViewController:imagePicker animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //get the image
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //put the image into dropbox
    if([self addImageToDropbox:image]) {
        //reload the data
        [self.tableView reloadData];
    }
    
    //and dismiss the camera view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)addImageToDropbox:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
    DBPath *newPath = [[DBPath root] childPath:[NSString stringWithFormat:@"image_%i.jpg", arc4random()]];
    DBFile *file = [[DBFilesystem sharedFilesystem] createFile:newPath error:nil];
    [file writeData:imageData error:nil];
    
    return YES;
}


#pragma Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[DBFilesystem sharedFilesystem] listFolder:[DBPath root] error:nil] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get the files in the directory, put them into the array
    NSArray *items = [[DBFilesystem sharedFilesystem] listFolder:[DBPath root] error:nil];
    
    //create a cell or reuse one
    MCCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
    
    //get the file info of the row
    DBFileInfo *fileInfo= items[indexPath.row];
    //open the file
    DBFile *file = [[DBFilesystem sharedFilesystem] openFile:[fileInfo path] error:nil];
    
    //get the file status
    //if there is data available, set the image view image to that data
    if(file.status.cached)
        cell.imageView.image = [UIImage imageWithData:[file readData:nil]];
    
    //set the name of the image to the label
    cell.imageLocationLabel.text = [[fileInfo path] name];
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //only want the segue if displaying the image
    if ([segue.identifier isEqualToString:@"displayImageSegue"]) {
        //create the new view controller
        MCCDisplayImageViewController *displayImageVC = (MCCDisplayImageViewController *)segue.destinationViewController;
        
        //get the items, file info, and file. There's probably a better more efficient way to do this
        NSArray *items = [[DBFilesystem sharedFilesystem] listFolder:[DBPath root] error:nil];
        DBFileInfo *fileInfo= items[[self.tableView indexPathForSelectedRow].row];
        DBFile *file = [[DBFilesystem sharedFilesystem] openFile:[fileInfo path] error:nil];
        
        //set the image if the image is available
        if(file.status.cached){
            displayImageVC.image = [UIImage imageWithData:[file readData:nil]];
        }
    }
}

@end
