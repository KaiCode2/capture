//
//  PhotoCell.h
//  capture
//
//  Created by kai don aldag on 2014-08-19.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UICollectionViewCell

@property (strong, nonatomic)UILabel *titleLabel;
@property (strong, nonatomic)UITextView *descriptionView;
@property (strong, nonatomic)UIImageView *imageView;
@property (strong, nonatomic)UIButton *shareButton;

@end
