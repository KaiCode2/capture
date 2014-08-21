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
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.titleLabel = [[UILabel alloc]initWithFrame: CGRectMake(5, 135, 125, 50)];
        self.descriptionView = [[UITextView alloc] initWithFrame: CGRectMake(5, 190, 100, 100)];
        
        [self.contentView addSubview: self.descriptionView];
        [self.contentView addSubview: self.titleLabel];
        [self.contentView addSubview: self.imageView];
    }
    return self;
}

@end
