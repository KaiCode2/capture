//
//  UpdateViewController.h
//  capture
//
//  Created by kai don aldag on 2014-08-20.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterScrollView.h"

@interface UpdateViewController : UIViewController <UIScrollViewDelegate, FilterScrollViewDelegate>

@property (strong, nonatomic) UIImage *theImage;

@end
