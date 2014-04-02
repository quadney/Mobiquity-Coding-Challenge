//
//  MCCTableViewCell.h
//  Mobiquity Coding Challenge
//
//  Created by Sydney Richardson on 4/2/14.
//  Copyright (c) 2014 Sydney Richardson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCCTableViewCell : UITableViewCell
@property (weak, nonatomic, readwrite) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *imageLocationLabel;

@end
