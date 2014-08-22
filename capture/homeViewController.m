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

@implementation homeViewController{
    UICollectionViewFlowLayout *layout;
    BOOL isSelected;
}

- (id)init
{
    self.photos = [[NSMutableArray alloc] init];
    
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc]initWithString: @"Capture"];
    [attrStr addAttribute: NSForegroundColorAttributeName value: [UIColor colorWithRed:0 green:0 blue:8 alpha:0.6] range: NSMakeRange(0, 7)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"SnellRoundhand-Black" size:38.0] range:NSMakeRange(0, 7)];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.attributedText = attrStr;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    
    layout = [[UICollectionViewFlowLayout alloc] init];
    if (self) {
        isSelected = NO;
        UIImage *image = [UIImage imageNamed:@"galleryIcon.png"];
        UITabBarItem *tabBar = [[UITabBarItem alloc]initWithTitle:@"" image: image selectedImage:nil];
        self.tabBarItem = tabBar;
        
        CGFloat itemSpacing = 10.0;
        layout.minimumInteritemSpacing = itemSpacing;
        layout.itemSize = CGSizeMake(150, 150);
        layout.minimumLineSpacing = itemSpacing;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.headerReferenceSize = CGSizeMake(20.0, 20.0);
        layout.footerReferenceSize = CGSizeMake(50.0, 50.0);
    }
    return (self = [super initWithCollectionViewLayout:layout]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"colors.png"]];
    self.collectionView.backgroundView = imageView;
    [self.collectionView registerClass: [PhotoCell class] forCellWithReuseIdentifier: @"Photo"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.photos count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"Photo" forIndexPath: indexPath];
    
    NSLog(@"the array count is %lu", (unsigned long)[self.photos count]);
    
    PhotoModel* p = (PhotoModel*)[self.photos objectAtIndex:indexPath.row];
    
    
    cell.imageView.image = p.Image;
    cell.titleLabel.text = p.Title;
    cell.descriptionView.text = p.Description;
    cell.descriptionView.editable = NO;
    
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"colors.png"]];
    
    NSLog(@"number of cell");
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"did select");
//    [self collectionView:collectionView layout:layout sizeForItemAtIndexPath:indexPath];
    [self.collectionView performBatchUpdates:nil completion:nil];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([[self.collectionView cellForItemAtIndexPath:indexPath] isSelected] && isSelected == NO) {
        NSLog(@"size changed");
        [collectionView cellForItemAtIndexPath:indexPath].frame = [UIScreen mainScreen].bounds;
        PhotoCell *cellCast = (PhotoCell*)[collectionView cellForItemAtIndexPath:indexPath];
        CGFloat size = cellCast.frame.size.width - 32;
        isSelected = YES;
        cellCast.imageView.frame = CGRectMake(5, 5, size, size);
        return CGSizeMake(300, 700);
    }else if ([[self.collectionView cellForItemAtIndexPath:indexPath] isSelected] && isSelected == YES){
        NSLog(@"in else");
        [collectionView cellForItemAtIndexPath:indexPath].frame = [UIScreen mainScreen].bounds;
        PhotoCell *cellCast = (PhotoCell*)[collectionView cellForItemAtIndexPath:indexPath];
        isSelected = YES;
        cellCast.imageView.frame = CGRectMake(25, 25, 100, 100);
        isSelected = NO;
        return CGSizeMake(150.0, 150.0);
    }
    return CGSizeMake(150.0, 150.0);
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
