//
//  FilterModel.m
//  capture
//
//  Created by kai don aldag on 2014-08-20.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import "FilterScrollView.h"
#import <GPUImage/GPUImage.h>

@implementation FilterScrollView{
}

-(instancetype)initWithImage:(UIImage*)image{
    self = [super init];
    if (self) {
        self.image = image;
        
        //
        UILabel *brightnessLabel = [[UILabel alloc] initWithFrame: CGRectMake(5, 15, 100, 75)];
        brightnessLabel.text = @"Brightness:";
        UISlider *brightnesSlider = [[UISlider alloc]initWithFrame:CGRectMake(150, 5, 150, 75)];
        [brightnesSlider addTarget:self
                            action:@selector(BrightnesSliderValue:)
                  forControlEvents:UIControlEventValueChanged];
        brightnesSlider.maximumValue = 1;
        brightnesSlider.minimumValue = -1;
        //
        UILabel *RGBLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 90, 100, 75)];
        
        //
        [self addSubview:brightnessLabel];
        [self addSubview:brightnesSlider];
        //
        
        self.scrollEnabled = YES;
        self.backgroundColor = [UIColor grayColor];
    }
    return self;

}

- (void)BrightnesSliderValue:(UISlider *)sender{
    _brightnessSliderValue = sender.value;
    //make a phone call by using delegate object
    //self.delegate //callmethod]
    
    [self.filterDelegate brightnessSliderDidChangeValue:sender.value];
}





@end
