//
//  VideoPlayerViewController.m
//  SimpleVideoPlayer
//
//  Created by Wu Huijie on 1/7/15.
//  Copyright (c) 2015 EdgeJay. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import <MobileVLCKit/MobileVLCKit.h>

@interface VideoPlayerViewController () {
    UIView *movieView;
    VLCMediaPlayer *mediaPlayer;
}

@end

@implementation VideoPlayerViewController

@synthesize videoPath;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    movieView = [[UIView alloc] initWithFrame: self.view.bounds];
    [self.view addSubview: movieView];
    
    mediaPlayer = [[VLCMediaPlayer alloc] init];
    [mediaPlayer setDrawable: movieView];
    
    //[mediaPlayer setMedia: [VLCMedia mediaWithURL: [NSURL URLWithString: @"http://streams.videolan.org/streams/mp4/Mr_MrsSmith-h264_aac.mp4"]]];
    [mediaPlayer setMedia: [VLCMedia mediaWithPath: self.videoPath]];
}

-(void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden: YES animated: YES];
    [mediaPlayer play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
