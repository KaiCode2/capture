//
//  NewViewController.m
//  capture
//
//  Created by kai don aldag on 2014-10-15.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import "NewViewController.h"
#import "UIImage+Resize.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTheImage:(UIImage *)theImage{
    
    //UIImage *newImage = [UIImage imageWithImage:theImage scaledToWidth:self.view.frame.size.width];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:theImage];
    [imageView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:imageView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
