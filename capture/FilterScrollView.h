//
//  FilterModel.h
//  capture
//
//  Created by kai don aldag on 2014-08-20.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import <UIKit/UIKit.h>

//make a delegate/@protocol called FilterScrollViewDelegate
//define a name for the delegate method(s)

@protocol FilterScrollViewDelegate <NSObject>

-(void)brightnessSliderDidChangeValue:(CGFloat)value;

@end


@interface FilterScrollView : UIScrollView 

@property (strong, nonatomic)UIImage *image;
@property float brightnessSliderValue;
//make a property out of the delegate as an object
@property (strong, nonatomic)NSObject <FilterScrollViewDelegate> *filterDelegate;

-(instancetype)initWithImage:(UIImage*)image;


@end
