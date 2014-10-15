//
//  homeViewController.h
//  capture
//
//  Created by kai don aldag on 2014-08-18.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PKImagePicker/PKImagePickerViewController.h>

@interface homeViewController : UICollectionViewController <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray *photos;

@property (strong, nonatomic)UIImage *selectedImage;

@end
