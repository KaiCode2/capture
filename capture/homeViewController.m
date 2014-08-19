//
//  homeViewController.m
//  capture
//
//  Created by kai don aldag on 2014-08-18.
//  Copyright (c) 2014 kai.don.aldag. All rights reserved.
//

#import "homeViewController.h"
#import "PhotoCell.h"
#import "PhotoModel.h"

@interface homeViewController ()

@end

@implementation homeViewController

- (id)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"galleryIcon.png"];
        UITabBarItem *tabBar = [[UITabBarItem alloc]initWithTitle:@"" image: image selectedImage:nil];
        self.tabBarItem = tabBar;
        
        CGFloat itemSpacing = 5.0;
        layout.minimumInteritemSpacing = itemSpacing;
        layout.itemSize = CGSizeMake(100, 100);
        layout.minimumLineSpacing = itemSpacing;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.headerReferenceSize = CGSizeMake(20.0, 20.0);
        layout.footerReferenceSize = CGSizeMake(50.0, 50.0);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"colors.png"]];
    self.collectionView.backgroundView = imageView;
    [self.collectionView registerClass: [UICollectionViewCell class] forCellWithReuseIdentifier: @"Photo"];
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"Photo" forIndexPath: indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
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
