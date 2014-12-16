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
#import "UpdateViewController.h"
#import "UIImage+crop_image.h"
#import "NewViewController.h"

@interface homeViewController ()
@end

@implementation homeViewController{
    UICollectionViewFlowLayout *layout;
    BOOL isSelected;
    UIActionSheet *photoSheet;
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
        UITabBarItem *tabBar = [[UITabBarItem alloc]initWithTitle:@"" image:image selectedImage:nil];
        self.tabBarItem = tabBar;
        
        UIImage *cameraImage = [UIImage imageWithImage:[UIImage imageNamed:@"cameraIcon.png"] scaledToSize:CGSizeMake(40, 40)];
        UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithImage:cameraImage style:UIBarButtonItemStylePlain target:self action:@selector(presentCameraSheet)];
        [self.navigationItem setLeftBarButtonItem:button];
        
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
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"colors.png"]];
    self.collectionView.backgroundView = imageView;
    
    [self.collectionView registerClass: [PhotoCell class] forCellWithReuseIdentifier: @"Photo"];
    
    self.selectedImage = [[UIImage alloc]init];
    
    self.picker  = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    self.picker.allowsEditing = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}

#pragma mark - camera methods

-(void)presentCameraSheet{
    photoSheet = [[UIActionSheet alloc]initWithTitle:@"Choose a photo source."
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

-(void) showCamera {
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        UIAlertView *noCameraAlert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message: @"It appears you have no camera availible or you didn't let us you yours." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [noCameraAlert show];
        return;
    }
    
    [self presentViewController:self.picker animated:YES completion:nil];
}

-(void) showGallery {
    [self.picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:self.picker animated:YES completion:nil];
}

-(void)imageSelectionCancelled{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imageSelected:(UIImage *)img{
//    UIImage *orientedImage = [UIImage imageWithCIImage:[img CIImage] scale:1.0 orientation:UIImageOrientationUp];
    
    self.selectedImage = img;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //NewViewController *updateViewController = [[NewViewController alloc] init];
    
    UpdateViewController *updateViewController = [[UpdateViewController alloc]init];
    updateViewController.theImage = self.selectedImage;
    updateViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:updateViewController animated: YES];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    if(!img) img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.selectedImage = img;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //present edit view controller
    UpdateViewController *updateViewController = [[UpdateViewController alloc]init];
    updateViewController.theImage = self.selectedImage;
    updateViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:updateViewController animated: YES];
}

#pragma mark - share title

-(void)shareTitle:(id)sender{
    UIButton *senderButton = (UIButton*)sender;
    
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    PhotoModel *senderModel = (PhotoModel*)[self.photos objectAtIndex:senderButton.tag];
    
    if (senderModel.Title && senderModel.Description) {
        NSString* postString = [[NSString alloc]init];
        [postString stringByAppendingString:senderModel.Title];
        [postString stringByAppendingString:@" "];
        [postString stringByAppendingString:senderModel.Description];
        
        
        [sharingItems addObject:postString];
    }
    if (senderModel.Image) {
        [sharingItems addObject:senderModel.Image];
    }
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}

#pragma mark - collectionView set up

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
    [cell.shareButton addTarget:self action:@selector(shareTitle:) forControlEvents:UIControlEventTouchUpInside];
    cell.shareButton.tag = indexPath.row;
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

@end
