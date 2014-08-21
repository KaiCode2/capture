//
//  FilterModel.m
//  capture
//
//  Created by kai don aldag on 2014-08-20.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import "FilterScrollView.h"
#import <GPUImage/GPUImage.h>

@implementation FilterScrollView

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
        UILabel *redLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 90, 150, 75)];
        redLabel.text = @"Amount of red:";
        UISlider *redSlider = [[UISlider alloc]initWithFrame:CGRectMake(150, 80, 150, 75)];
        [redSlider addTarget:self
                      action:@selector(redSliderValue:)
            forControlEvents:UIControlEventValueChanged];
        redSlider.minimumValue = 1.0;
        redSlider.maximumValue = 2.0;
        //
        UILabel *blueLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 165, 150, 75)];
        blueLabel.text = @"Amount of blue:";
        UISlider *blueSlider = [[UISlider alloc]initWithFrame:CGRectMake(150, 155, 150, 75)];
        [blueSlider addTarget:self
                       action:@selector(blueSliderChangeValue:)
             forControlEvents:UIControlEventValueChanged];
        blueSlider.minimumValue = 1.0;
        blueSlider.maximumValue = 2.0;
        //
        UILabel *greenLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 240, 150, 75)];
        greenLabel.text = @"Amount of green";
        UISlider *greenSlider = [[UISlider alloc]initWithFrame:CGRectMake(150, 230, 150, 75)];
        [greenSlider addTarget:self
                        action:@selector(greenSliderChangeValue:)
              forControlEvents:UIControlEventValueChanged];
        greenSlider.minimumValue = 1.0;
        greenSlider.maximumValue = 2.0;
        //
        UILabel *slopperLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 310, 150, 75)];
        slopperLabel.text = @"haze sloppe";
        UISlider *slopperSlider = [[UISlider alloc]initWithFrame:CGRectMake(150, 300, 150, 75)];
        [slopperSlider addTarget:self
                          action:@selector(hazeFilterSloper:)
                forControlEvents:UIControlEventValueChanged];
        slopperSlider.minimumValue = -3;
        slopperSlider.maximumValue = 0.5;
        //
        UILabel *distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 380, 150, 75)];
        distanceLabel.text = @"haze sloppe";
        UISlider *distanceSlider = [[UISlider alloc]initWithFrame:CGRectMake(150, 370, 150, 75)];
        [distanceSlider addTarget:self
                          action:@selector(hazeFilterDistance:)
                forControlEvents:UIControlEventValueChanged];
        distanceSlider.minimumValue = -3;
        distanceSlider.maximumValue = 0.5;
        //
        [self addSubview:distanceSlider];
        [self addSubview:distanceLabel];
        [self addSubview:slopperSlider];
        [self addSubview:slopperLabel];
        [self addSubview:greenSlider];
        [self addSubview:greenLabel];
        [self addSubview:blueSlider];
        [self addSubview:blueLabel];
        [self addSubview:redLabel];
        [self addSubview:redSlider];
        [self addSubview:brightnessLabel];
        [self addSubview:brightnesSlider];
        //
        self.scrollEnabled = YES;
        self.contentSize = CGSizeMake(self.frame.size.width, 1000);
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

- (void)redSliderValue:(UISlider *)sender{
    _redSliderValue = sender.value;
    
    [self.filterDelegate redSliderChangeValue:sender.value];
}

-(void)blueSliderChangeValue:(UISlider *)sender{
    _blueSliderValue = sender.value;
    
    [self.filterDelegate blueSliderChangeValue:sender.value];
}

-(void)greenSliderChangeValue:(UISlider *)sender{
    _greenSliderValue = sender.value;
    
    [self.filterDelegate greenSliderChangeValue:sender.value];
}

-(void)hazeFilterDistance:(UISlider *)sender{
    _distanceSliderValue = sender.value;
    
    [self.filterDelegate hazeFilterDistance:sender.value];
}

-(void)hazeFilterSloper:(UISlider *)sender{
    _slopperSliderValue = sender.value;
    
    [self.filterDelegate hazeFilterSloper:sender.value];
}

@end
