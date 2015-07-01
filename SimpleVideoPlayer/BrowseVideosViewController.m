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
#import <MobileVLCKit/MobileVLCKit.h>

@interface BrowseVideosViewController () {
    ALAssetsLibrary *videoAssetsLib;
    NSMutableArray *videos;
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
    
    videos = [[NSMutableArray alloc] initWithCapacity: 0];
    
    // Calling the following method will also trigger alert to be displayed asking user for access
    // to photos if not granted before
    
    [videoAssetsLib enumerateGroupsWithTypes: ALAssetsGroupAll usingBlock: ^(ALAssetsGroup *group, BOOL *stop) {
        
        // Use filter to get video files only
        ALAssetsFilter *filter = [ALAssetsFilter allVideos];
        [group setAssetsFilter: filter];
        
        [group enumerateAssetsUsingBlock: ^(ALAsset *result, NSUInteger index, BOOL *stop) {
            // result might be null, so need to watch out
            if (result) {
                [videos addObject: result];
            }
        }];
        
        [self.collectionView reloadData];
        
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
    return 1;
}

- (NSInteger)collectionView: (UICollectionView *)collectionView numberOfItemsInSection: (NSInteger)section {
    return videos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: reuseIdentifier forIndexPath: indexPath];
    
    // Get ALAsset
    ALAsset *videoAsset = [videos objectAtIndex: indexPath.item];
    
    // Configure the cell
    //CGFloat cellWd = cell.bounds.size.width;
    //CGFloat cellHt = cell.bounds.size.height;
    UIImageView *imgView;
    
    // See if cell already has image view. If not create one.
    if (![cell viewWithTag: 10]) {
        NSLog(@"need to create image view");
        
        imgView = [[UIImageView alloc] initWithFrame: CGRectMake(5.0f, 5.0f, 70.0f, 70.0f)];
        [imgView setClipsToBounds: YES];
        [imgView setContentMode: UIViewContentModeScaleAspectFill];
        [imgView setBackgroundColor: [UIColor blackColor]];
        [imgView setTag: 10];
        [cell addSubview: imgView];
    }
    else {
        NSLog(@"re-using image view");
        imgView = (UIImageView *)[cell viewWithTag: 10];
    }
    
    [imgView setImage: [UIImage imageWithCGImage: videoAsset.aspectRatioThumbnail]];
    
    [cell setBackgroundColor: [UIColor whiteColor]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView: (UICollectionView *)collectionView shouldHighlightItemAtIndexPath: (NSIndexPath *)indexPath {
	return YES;
}

- (BOOL)collectionView: (UICollectionView *)collectionView shouldSelectItemAtIndexPath: (NSIndexPath *)indexPath {
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get ALAsset
    ALAsset *videoAsset = [videos objectAtIndex: indexPath.item];
    
    if (videoAsset) {
        ALAssetRepresentation *rep = videoAsset.defaultRepresentation;
        [(NavController *)self.navigationController gotoVideoPlayer: rep.url];
    }
}

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
