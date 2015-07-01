//
//  VideoPlayerViewController.m
//  SimpleVideoPlayer
//
//  Created by Wu Huijie on 1/7/15.
//  Copyright (c) 2015 EdgeJay. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import <MobileVLCKit/MobileVLCKit.h>

@interface VideoPlayerViewController () <UIGestureRecognizerDelegate> {
    VLCMediaPlayer *mediaPlayer;
    NSUInteger currentAudioTrack;
    BOOL muteAudio;
}

@property (nonatomic, weak) IBOutlet UIView *movieView;
@property (nonatomic, weak) IBOutlet UIButton *movieOverlayButton;
@property (nonatomic, weak) IBOutlet UIView *playbackControlsView;
@property (nonatomic, weak) IBOutlet UIButton *playButton;
@property (nonatomic, weak) IBOutlet UIButton *muteButton;

@end

@implementation VideoPlayerViewController

@synthesize videoPath, movieView, movieOverlayButton, playbackControlsView, playButton, muteButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    [self.movieView setUserInteractionEnabled: YES];
    [self.view addSubview: self.movieView];
    
    mediaPlayer = [[VLCMediaPlayer alloc] init];
    [mediaPlayer setDrawable: movieView];
    
    //[mediaPlayer setMedia: [VLCMedia mediaWithURL: [NSURL URLWithString: @"http://streams.videolan.org/streams/mp4/Mr_MrsSmith-h264_aac.mp4"]]];
    [mediaPlayer setMedia: [VLCMedia mediaWithPath: self.videoPath]];
    
    [self.view bringSubviewToFront: self.movieOverlayButton];
    [self.view bringSubviewToFront: self.playbackControlsView];
    
    muteAudio = NO;
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear: animated];
    
    [self.navigationController setNavigationBarHidden: YES animated: YES];
    [self.playbackControlsView setHidden: YES];
    
    [mediaPlayer play];
    
    currentAudioTrack = mediaPlayer.currentAudioTrackIndex;
}

-(void)viewWillDisappear:(BOOL)animated {
    
    if ([mediaPlayer isPlaying]) {
        [mediaPlayer stop];
        [mediaPlayer setDrawable: nil];
        mediaPlayer = nil;
    }
    
    [super viewWillDisappear: animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onMovieViewClick:(id)sender {
    
    [self.navigationController setNavigationBarHidden: !self.navigationController.navigationBarHidden
                                             animated: YES];
    
    [self.playbackControlsView setHidden: self.navigationController.navigationBarHidden];
}

-(IBAction)onPlayButtonClick:(id)sender {
    
    if ([mediaPlayer isPlaying]) {
        [self.playButton setImage: [UIImage imageNamed: @"button-play.png"] forState: UIControlStateNormal];
        [mediaPlayer pause];
    }
    else {
        [self.playButton setImage: [UIImage imageNamed: @"button-pause.png"] forState: UIControlStateNormal];
        [mediaPlayer play];
    }
}

-(IBAction)onMuteButtonClick:(id)sender {
    
    if (!muteAudio) {
        muteAudio = YES;
        mediaPlayer.currentAudioTrackIndex = -1;
        [self.muteButton setImage: [UIImage imageNamed: @"speaker-off.png"] forState: UIControlStateNormal];
    }
    else {
        muteAudio = NO;
        mediaPlayer.currentAudioTrackIndex = 1;
        [self.muteButton setImage: [UIImage imageNamed: @"speaker-on.png"] forState: UIControlStateNormal];
    }
}

@end
