//
//  CaptionsViewController.m
//  capture
//
//  Created by kai don aldag on 2014-08-21.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import "CaptionsViewController.h"

@interface CaptionsViewController ()

@end

@implementation CaptionsViewController{
    UIImageView *photoImageView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 63, 320, 320)];
        [self.view addSubview:photoImageView];
        
        UITextField *titleField = [[UITextField alloc]initWithFrame:CGRectMake(10, 400, 300, 35)];
        titleField.placeholder = @"Title";
        UITextView *descriptionField = [[UITextView alloc]initWithFrame:CGRectMake(10, 450, 300, 100)];
        
        titleField.backgroundColor = [UIColor colorWithRed:2.5 green:5 blue:5 alpha:0.9];
        descriptionField.backgroundColor = [UIColor colorWithRed:2.5 green:5 blue:5 alpha:0.9];
        titleField.textAlignment = NSTextAlignmentCenter;
        titleField.layer.cornerRadius = 10;
        titleField.layer.masksToBounds = YES;
        descriptionField.layer.cornerRadius = 10;
        descriptionField.layer.masksToBounds = YES;
        [self.view addSubview:descriptionField];
        [self.view addSubview:titleField];
        
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc]initWithString: @"Capture"];
        [attrStr addAttribute: NSForegroundColorAttributeName value: [UIColor colorWithRed:0 green:0 blue:8 alpha:0.6] range: NSMakeRange(0, 7)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SnellRoundhand-Black" size:38.0] range:NSMakeRange(0, 7)];
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.attributedText = attrStr;
        [titleLabel sizeToFit];
        self.navigationItem.titleView = titleLabel;
        
        self.view.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setTheImage:(UIImage *)theImage{
    _theImage = theImage;
    photoImageView.image = self.theImage;
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
