//
//  PhotoModel.m
//  capture
//
//  Created by kai don aldag on 2014-08-19.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.Title = title;
        self.Description = description;
        self.Image = image;
    }
    return self;
}

@end
