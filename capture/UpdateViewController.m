//
//  UpdateViewController.m
//  capture
//
//  Created by kai don aldag on 2014-08-20.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import "UpdateViewController.h"
#import "CameraViewController.h"
#import "CaptionsViewController.h"
#import "UIImage+Resize.h"
#import <GPUImage.h>

@interface UpdateViewController ()

@property (nonatomic) UIImageView * photoImageView;
@property (nonatomic) UIButton *slidersButton;
@property (nonatomic) UIButton *filterButton;

@end

@implementation UpdateViewController{
    GPUImageBrightnessFilter *brightnessFilter;
    GPUImageRGBFilter *RGBFilter;
    GPUImageHazeFilter *hazeFilter;
    GPUImagePicture *sourcePicture;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIImageView *photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 63, 320, 320)];
        self.photoImageView = photoImageView;
        [self.view addSubview:photoImageView];
        
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(presentNextViewController)];
        
        self.navigationItem.rightBarButtonItem = done;
        
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc]initWithString: @"Capture"];
        [attrStr addAttribute: NSForegroundColorAttributeName value: [UIColor colorWithRed:0 green:0 blue:8 alpha:0.6] range: NSMakeRange(0, 7)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir-Book" size:38.0] range:NSMakeRange(0, 7)];
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.attributedText = attrStr;
        [titleLabel sizeToFit];
        self.navigationItem.titleView = titleLabel;        
        }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    _slidersButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x + 5, 383, 160, 200)];
    UIImageView *sliderImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Sliders-512.png"]];
    sliderImageView.frame = CGRectMake(30, 50, 100, 100);
    _slidersButton.backgroundColor = [UIColor grayColor];
    [_slidersButton addTarget:self action:@selector(customFilers) forControlEvents: UIControlEventTouchUpInside];
    [_slidersButton addSubview:sliderImageView];
    
    _filterButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 383, 160, 200)];
    UIImageView *filterImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabs.png"]];
    filterImageView.frame = CGRectMake(30, 50, 100, 100);
    _filterButton.backgroundColor = [UIColor grayColor];
    [_filterButton addTarget:self action:@selector(setFilters) forControlEvents: UIControlEventTouchUpInside];
    [_filterButton addSubview:filterImageView];
    
    [self.view addSubview:self.filterButton];
    [self.view addSubview:self.slidersButton];
}

-(void)didReceiveMemoryWarning{
    NSLog(@"memory warning ahhhhh!!!");
}

- (void)setTheImage:(UIImage *)theImage{
    //TODO: the orientation is side ways so try using the .imageOrientation property to fix it.
    //the line below is close but not it
//    theImage = [UIImage imageWithCGImage:[theImage CGImage] scale:1.0 orientation:UIImageOrientationUp];
    _theImage = theImage;
    [theImage fixOrientation];
    sourcePicture = [[GPUImagePicture alloc] initWithImage:theImage];
    brightnessFilter = [[GPUImageBrightnessFilter alloc]init];
    hazeFilter = [[GPUImageHazeFilter alloc]init];
    RGBFilter = [[GPUImageRGBFilter alloc]init];
    brightnessFilter.brightness = 0;
    RGBFilter.red = 1;
    RGBFilter.blue = 1;
    RGBFilter.green = 1;
    hazeFilter.distance = 0;
    hazeFilter.slope = 0;
    [sourcePicture addTarget:brightnessFilter];
    [brightnessFilter useNextFrameForImageCapture];
    [brightnessFilter addTarget:RGBFilter];
    [RGBFilter useNextFrameForImageCapture];
    [RGBFilter addTarget:hazeFilter];
    [hazeFilter useNextFrameForImageCapture];
    [sourcePicture processImage];
    _photoImageView.image = [RGBFilter imageFromCurrentFramebuffer];
}

#pragma mark - set up filters

-(void)customFilers{
    self.filterButton.hidden = YES;
    self.slidersButton.hidden = YES;
    
    FilterScrollView *slidersView = [[FilterScrollView alloc] initWithImage: self.theImage];
    slidersView.frame = CGRectMake(0, 383, 320, 200);
    slidersView.filterDelegate = self;
    [self.view addSubview:slidersView];
}

//implement the delegate method here

-(void)setFilters{
    self.filterButton.hidden = YES;
    self.slidersButton.hidden = YES;
}

#pragma mark - protocol implementations

-(void)brightnessSliderDidChangeValue:(CGFloat)value{
    NSLog(@"the value is %f", value);
    
    brightnessFilter.brightness = value;
    [brightnessFilter useNextFrameForImageCapture];
    [RGBFilter useNextFrameForImageCapture];
    [hazeFilter useNextFrameForImageCapture];
    [sourcePicture processImage];
    _photoImageView.image = [RGBFilter imageFromCurrentFramebuffer];
}

-(void)redSliderChangeValue:(CGFloat)value{
    NSLog(@"the red value is %f", value);
    
    RGBFilter.red = value;
    [brightnessFilter useNextFrameForImageCapture];
    [RGBFilter useNextFrameForImageCapture];
    [hazeFilter useNextFrameForImageCapture];
    [sourcePicture processImage];
    _photoImageView.image = [RGBFilter imageFromCurrentFramebuffer];
}

-(void)blueSliderChangeValue:(CGFloat)value{
    NSLog(@"the blue value is %f", value);
    
    RGBFilter.blue = value;
    [brightnessFilter useNextFrameForImageCapture];
    [RGBFilter useNextFrameForImageCapture];
    [hazeFilter useNextFrameForImageCapture];
    [sourcePicture processImage];
    _photoImageView.image = [RGBFilter imageFromCurrentFramebuffer];
}

-(void)greenSliderChangeValue:(CGFloat)value{
    NSLog(@"the green value is %f", value);
    
    RGBFilter.green = value;
    [brightnessFilter useNextFrameForImageCapture];
    [RGBFilter useNextFrameForImageCapture];
    [hazeFilter useNextFrameForImageCapture];
    [sourcePicture processImage];
    _photoImageView.image = [RGBFilter imageFromCurrentFramebuffer];
}

-(void)hazeFilterSloper:(CGFloat)value{
    NSLog(@"the slopper haze is %f", value);
    
    hazeFilter.slope = value;
    [brightnessFilter useNextFrameForImageCapture];
    [RGBFilter useNextFrameForImageCapture];
    [hazeFilter useNextFrameForImageCapture];
    [sourcePicture processImage];
    _photoImageView.image = [hazeFilter imageFromCurrentFramebuffer];
}

-(void)hazeFilterDistance:(CGFloat)value{
    NSLog(@"the distance haze is %f", value);
    
    hazeFilter.distance = value;
    [brightnessFilter useNextFrameForImageCapture];
    [RGBFilter useNextFrameForImageCapture];
    [hazeFilter useNextFrameForImageCapture];
    [sourcePicture processImage];
    _photoImageView.image = [hazeFilter imageFromCurrentFramebuffer];
}

#pragma mark - next view controller

-(void)presentNextViewController{
    CaptionsViewController *captionViewController = [[CaptionsViewController alloc]init];
    [self.navigationController pushViewController:captionViewController animated:YES];
    captionViewController.theImage = _photoImageView.image;
}

@end
