//
//  CameraViewController.m
//  capture
//
//  Created by kai don aldag on 2014-08-19.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"cameraIcon.png"];
        UITabBarItem *tabBar = [[UITabBarItem alloc]initWithTitle:@"" image: image selectedImage:nil];
        self.tabBarItem = tabBar;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: YES];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"colors.png"]];
    
    UIActionSheet *photoSheet = [[UIActionSheet alloc]initWithTitle:@"Choose a photo source."
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles: @"Take a photo", @"Choose existing", nil];
    
    [photoSheet showInView: self.view];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Take a photo"]) {
        NSLog(@"take photo");
        [self showCamera];
    }else if ([buttonTitle isEqualToString:@"Choose existing"]){
        NSLog(@"choose photo");
        [self showGallery];
    }
}



#pragma mark - photo pickers

-(void) showCamera {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        UIAlertView *noCameraAlert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message: @"It appears you have no camera availible or you didn't let us you yours." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [noCameraAlert show];
        return;
    }
    
    [self presentViewController:picker animated:YES completion:NULL];
}

-(void) showGallery {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    [self presentViewController:picker animated:YES completion:NULL];
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
