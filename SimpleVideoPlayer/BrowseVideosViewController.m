//
//  BrowseVideosViewController.m
//  SimpleVideoPlayer
//
//  Created by Huijie Wu on 30/6/15.
//  Copyright (c) 2015 EdgeJay. All rights reserved.
//

#import "BrowseVideosViewController.h"
#import "NavController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface BrowseVideosViewController () {
    ALAssetsLibrary *videoAssetsLib;
}

@end

@implementation BrowseVideosViewController

static NSString * const reuseIdentifier = @"VideoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass: [UICollectionViewCell class] forCellWithReuseIdentifier: reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
    // Fetch videos managed by Photos app
    [self fetchVideos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Video management methods
-(void)fetchVideos {
    
    if (!videoAssetsLib) {
        videoAssetsLib = [[ALAssetsLibrary alloc] init];
    }
    
    [videoAssetsLib enumerateGroupsWithTypes: ALAssetsGroupAll usingBlock: ^(ALAssetsGroup *group, BOOL *stop) {
        NSLog(@"%@", group);
    } failureBlock: ^(NSError *error) {
        [self showFetchVideosError];
    }];
}

#pragma mark - Alerts
-(void)showFetchVideosError {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Uh oh"
                                                    message: @"Unable to browse videos now. Make sure you have granted this app access to your Photos app"
                                                   delegate: nil
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: nil];
    
    [alert show];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 0;
}


- (NSInteger)collectionView: (UICollectionView *)collectionView numberOfItemsInSection: (NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: reuseIdentifier forIndexPath: indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark - UI actions
-(IBAction)onBack:(id)sender {
    [(NavController *)self.navigationController unwindToMain];
}

@end
