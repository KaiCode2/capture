//
//  PhotoCell.m
//  capture
//
//  Created by kai don aldag on 2014-08-19.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 25, 100, 100)];
        self.titleLabel = [[UILabel alloc]initWithFrame: CGRectMake(5, 300, 300, 75)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:25];
        self.descriptionView = [[UITextView alloc] initWithFrame: CGRectMake(5, 375, 275, 300)];
        self.descriptionView.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:15];
        self.descriptionView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview: self.descriptionView];
        [self.contentView addSubview: self.titleLabel];
        [self.contentView addSubview: self.imageView];
        
        [[[self contentView] superview] setClipsToBounds:YES];
    }
    return self;
}

@end
