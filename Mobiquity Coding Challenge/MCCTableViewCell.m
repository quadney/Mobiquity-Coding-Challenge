//
//  MCCTableViewCell.m
//  Mobiquity Coding Challenge
//
//  Created by Sydney Richardson on 4/2/14.
//  Copyright (c) 2014 Sydney Richardson. All rights reserved.
//

#import "MCCTableViewCell.h"

@implementation MCCTableViewCell

@synthesize imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
