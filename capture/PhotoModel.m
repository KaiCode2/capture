//
//  PhotoModel.m
//  capture
//
//  Created by kai don aldag on 2014-08-19.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

-(void)setTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image{
    _Title = title;
    _Description = description;
    _Image = image;
}

@end
