//
//  MCCDisplayImageViewController.m
//  Mobiquity Coding Challenge
//
//  Created by Sydney Richardson on 4/2/14.
//  Copyright (c) 2014 Sydney Richardson. All rights reserved.
//

#import "MCCDisplayImageViewController.h"

@interface MCCDisplayImageViewController ()


@end

@implementation MCCDisplayImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.imageView.image = self.image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
