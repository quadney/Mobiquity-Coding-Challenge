//
//  MCCDisplayImageViewController.h
//  Mobiquity Coding Challenge
//
//  Created by Sydney Richardson on 4/2/14.
//  Copyright (c) 2014 Sydney Richardson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCCDisplayImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;
@end
