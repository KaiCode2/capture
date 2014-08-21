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

-(void)redSliderChangeValue:(CGFloat)value;
-(void)blueSliderChangeValue:(CGFloat)value;
-(void)greenSliderChangeValue:(CGFloat)value;

-(void)hazeFilterDistance:(CGFloat)value;
-(void)hazeFilterSloper:(CGFloat)value;

@end


@interface FilterScrollView : UIScrollView 

@property (strong, nonatomic)UIImage *image;
//make a property out of the delegate as an object
@property (strong, nonatomic)NSObject <FilterScrollViewDelegate> *filterDelegate;

@property float brightnessSliderValue;
@property float redSliderValue;
@property float blueSliderValue;
@property float greenSliderValue;
@property float slopperSliderValue;
@property float distanceSliderValue;

-(instancetype)initWithImage:(UIImage*)image;


@end
