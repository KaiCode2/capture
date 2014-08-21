//
//  UpdateViewController.m
//  capture
//
//  Created by kai don aldag on 2014-08-20.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import "UpdateViewController.h"
#import "CameraViewController.h"
#import <GPUImage.h>

@interface UpdateViewController ()

@property (nonatomic) UIImageView * photoImageView;
@property (nonatomic) UIButton *slidersButton;
@property (nonatomic) UIButton *filterButton;

@end

@implementation UpdateViewController{
    GPUImageBrightnessFilter *brightnessFilter;
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
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SnellRoundhand-Black" size:38.0] range:NSMakeRange(0, 7)];
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.attributedText = attrStr;
        [titleLabel sizeToFit];
        self.navigationItem.titleView = titleLabel;
        
        self.tabBarController.tabBar.hidden = YES;
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

- (void)setTheImage:(UIImage *)theImage{
    _theImage = theImage;
    sourcePicture = [[GPUImagePicture alloc] initWithImage:theImage];
    brightnessFilter = [[GPUImageBrightnessFilter alloc]init];
    brightnessFilter.brightness = 0;
    [sourcePicture addTarget:brightnessFilter];
    [brightnessFilter useNextFrameForImageCapture];
    [sourcePicture processImage];
    UIImage *filteredimage = [brightnessFilter imageFromCurrentFramebuffer];
    _photoImageView.image = [[UIImage alloc]init];
    _photoImageView.image = filteredimage;
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

-(void)brightnessSliderDidChangeValue:(CGFloat)value{
    NSLog(@"the value is %f", value);
    
    brightnessFilter.brightness = value;
    [brightnessFilter useNextFrameForImageCapture];
    [sourcePicture processImage];
    _photoImageView.image = [brightnessFilter imageFromCurrentFramebuffer];
}



#pragma mark - next view controller

-(void)presentNextViewController{
    //TODO make the next view controller and add it
//    [self presentViewController: animated:YES completion:NULL];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
