//
//  CaptionsViewController.m
//  capture
//
//  Created by kai don aldag on 2014-08-21.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import "CaptionsViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "CameraViewController.h"

@interface CaptionsViewController ()

@end

@implementation CaptionsViewController{
    UIImageView *photoImageView;
    UITextField *titleField;
    UITextView *descriptionField;
    ALAssetsLibrary *library;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        library = [[ALAssetsLibrary alloc] init];
        
        photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 70, 100, 100)];
        [self.view addSubview:photoImageView];
        
        titleField = [[UITextField alloc]initWithFrame:CGRectMake(125, 105, 175, 35)];
        titleField.placeholder = @"Title";
        descriptionField = [[UITextView alloc]initWithFrame:CGRectMake(10, 200, 300, 300)];
        descriptionField.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:15];
        
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(presentNextViewController)];
        
        
        self.navigationItem.rightBarButtonItem = done;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
        
        [self.view addGestureRecognizer:tapRecognizer];
        
        titleField.backgroundColor = [UIColor colorWithRed:2.5 green:5 blue:5 alpha:0.9];
        descriptionField.backgroundColor = [UIColor colorWithRed:2.5 green:5 blue:5 alpha:0.9];
        titleField.textAlignment = NSTextAlignmentCenter;
        titleField.layer.cornerRadius = 10;
        titleField.layer.masksToBounds = YES;
        descriptionField.layer.cornerRadius = 10;
        descriptionField.layer.masksToBounds = YES;
        photoImageView.layer.cornerRadius = 10;
        photoImageView.layer.masksToBounds = YES;
        [self.view addSubview:descriptionField];
        [self.view addSubview:titleField];
        
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc]initWithString: @"Capture"];
        [attrStr addAttribute: NSForegroundColorAttributeName value: [UIColor colorWithRed:0 green:0 blue:8 alpha:0.6] range: NSMakeRange(0, 7)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SnellRoundhand-Black" size:38.0] range:NSMakeRange(0, 7)];
        
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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"colors.png"]];
}

-(void)setTheImage:(UIImage *)theImage{
    _theImage = theImage;
    photoImageView.image = self.theImage;
}

-(void)tapGesture{
    [titleField resignFirstResponder];
    [descriptionField resignFirstResponder];
}

-(void)presentNextViewController{
    if (titleField.text.length > 20) {
        UIAlertView *toLongAlert = [[UIAlertView alloc]initWithTitle:@"oops." message:@"it appears your title is too long!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [toLongAlert show];
        return;
    }else if (titleField.text.length == 0){
        UIAlertView *toShortAlert = [[UIAlertView alloc]initWithTitle:@"oops." message:@"it appears you don't have a title!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [toShortAlert show];
        return;
    }else{
        self.photoModel = [[PhotoModel alloc]initWithTitle:titleField.text description:descriptionField.text image:photoImageView.image];
        
        [library saveImage:photoImageView.image toAlbum:@"Capture" withCompletionBlock:^(NSError *error) {
            if (error) {
                NSLog(@"the error was %@", error);
            }
        }];
        
        //    self.photoModel.Image = photoImageView.image;
        //    self.photoModel.Title = titleField.text;
        //    self.photoModel.Description = descriptionField.text;
        //    [self.photoModel setTitle:titleField.text description:descriptionField.text image:photoImageView.image];
        
        homeViewController *gallery = [[[[self.tabBarController viewControllers] objectAtIndex:1] viewControllers] firstObject];
        
        [gallery.photos addObject: self.photoModel];
        
        self.tabBarController.selectedIndex = 1;
        
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
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
