//
//  PhotoModel.h
//  capture
//
//  Created by kai don aldag on 2014-08-19.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoModel : NSObject

@property (strong, nonatomic)UIImage *Image;
@property (strong, nonatomic) NSString *Title;
@property (strong, nonatomic) NSString *Description;

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image;
@end
