//
//  BrowseVideosViewController.m
//  SimpleVideoPlayer
//
//  Created by Huijie Wu on 30/6/15.
//  Copyright (c) 2015 EdgeJay. All rights reserved.
//

#import "BrowseVideosViewController.h"
#import "NavController.h"
//#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileVLCKit/MobileVLCKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BrowseVideosViewController () {
    //ALAssetsLibrary *videoAssetsLib;
    NSMutableArray *videos;
    NSMutableDictionary *thumbnails;
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
    thumbnails = [[NSMutableDictionary alloc] initWithCapacity: 0];
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
    
    /*
    if (!videoAssetsLib) {
        videoAssetsLib = [[ALAssetsLibrary alloc] init];
    }
    */
    
    videos = [[NSMutableArray alloc] initWithCapacity: 0];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    
    [videos addObject: [mainBundle pathForResource: @"big_buck_bunny" ofType: @"mp4"]];
    [videos addObject: [mainBundle pathForResource: @"elephants_dream" ofType: @"mp4"]];
    
    [self.collectionView reloadData];
    
    // Calling the following method will also trigger alert to be displayed asking user for access
    // to photos if not granted before
    /*
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
    */
}

/*
#pragma mark - Alerts
-(void)showFetchVideosError {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Uh oh"
                                                    message: @"Unable to browse videos now. Make sure you have granted this app access to your Photos app"
                                                   delegate: nil
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: nil];
    
    [alert show];
}
*/

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
    //ALAsset *videoAsset = [videos objectAtIndex: indexPath.item];
    
    // Get video path
    NSString *videoPath = [videos objectAtIndex: indexPath.item];
    
    // Configure the cell
    UIImageView *imgView;
    UIActivityIndicatorView *activityView;
    
    // Setup activity indicator
    if (![cell viewWithTag: 11]) {
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [activityView setCenter: CGPointMake(40.0f, 40.0f)];
        [activityView setTag: 11];
        [cell addSubview: activityView];
    }
    else {
        activityView = (UIActivityIndicatorView *)[cell viewWithTag: 11];
    }
    
    // See if cell already has image view. If not create one.
    if (![cell viewWithTag: 10]) {
        
        imgView = [[UIImageView alloc] initWithFrame: CGRectMake(5.0f, 5.0f, 70.0f, 70.0f)];
        [imgView setClipsToBounds: YES];
        [imgView setContentMode: UIViewContentModeScaleAspectFill];
        [imgView setBackgroundColor: [UIColor blackColor]];
        [imgView setTag: 10];
        [cell addSubview: imgView];
    }
    else {
        imgView = (UIImageView *)[cell viewWithTag: 10];
    }
    
    
    //[imgView setImage: [UIImage imageWithCGImage: videoAsset.aspectRatioThumbnail]];
    
    
    // Check if video thumbnail was already generated before
    if ([thumbnails objectForKey: videoPath]) {
        [imgView setImage: (UIImage *)[thumbnails objectForKey: videoPath]];
    }
    else {
        // Show cell as busy
        [activityView setHidden: NO];
        [activityView startAnimating];
        
        // Retrieve single video frame to use as thumbnail
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL: [[NSURL alloc] initFileURLWithPath: videoPath] options: nil];
        
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset: asset];
        gen.appliesPreferredTrackTransform = YES;
        gen.maximumSize = CGSizeMake(200.0f, 200.0f);
        
        CMTime time = CMTimeMakeWithSeconds(60.0, 24000);
        
        [gen generateCGImagesAsynchronouslyForTimes: @[[NSValue valueWithCMTime: time]] completionHandler: ^(CMTime requestedTime, CGImageRef image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error) {
            
            [activityView setHidden: YES];
            [activityView stopAnimating];
            
            if (result == AVAssetImageGeneratorSucceeded) {
                
                UIImage *img = [UIImage imageWithCGImage: image];
                [imgView setImage: img];
                
                // Cache in dictionary
                [thumbnails setObject: img forKey: videoPath];
            }
            else {
                NSLog(@"failed to create thumbnail image for video");
                NSLog(@"%@", error);
            }
        }];
    }
    
    [cell setBackgroundColor: [UIColor whiteColor]];
    [cell bringSubviewToFront: activityView];
    
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
    NSString *videoPath = (NSString *)[videos objectAtIndex: indexPath.item];
    
    if (videoPath) {
        [(NavController *)self.navigationController gotoVideoPlayer: videoPath];
    }
    
    /*
    // Get ALAsset
    ALAsset *videoAsset = [videos objectAtIndex: indexPath.item];
    
    if (videoAsset) {
        ALAssetRepresentation *rep = videoAsset.defaultRepresentation;
        [(NavController *)self.navigationController gotoVideoPlayer: rep.url];
    }
    */
}

#pragma mark - UI actions
-(IBAction)onBack:(id)sender {
    [(NavController *)self.navigationController unwindToMain];
}

@end
