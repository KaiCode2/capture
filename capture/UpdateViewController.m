//
//  UpdateViewController.m
//  capture
//
//  Created by kai don aldag on 2014-08-20.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import "UpdateViewController.h"
#import "CameraViewController.h"

@interface UpdateViewController ()

@end

@implementation UpdateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        CameraViewController *cameraViewController = [[CameraViewController alloc]init];
        
        self.theImage = [[UIImage alloc]init];
        UIImageView *photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 63, 320, 320)];
        photoImageView.backgroundColor = [UIColor greenColor];
        photoImageView.image = self.theImage;
        
        [self.view addSubview:photoImageView];
        
        NSLog(@"the image is %@", self.theImage);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
