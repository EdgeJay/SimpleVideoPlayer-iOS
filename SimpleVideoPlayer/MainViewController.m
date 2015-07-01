//
//  ViewController.m
//  SimpleVideoPlayer
//
//  Created by Wu Huijie on 30/6/15.
//  Copyright (c) 2015 EdgeJay. All rights reserved.
//

#import "MainViewController.h"
#import <MobileVLCKit/MobileVLCKit.h>

@interface MainViewController () {
    VLCMediaPlayer *mediaPlayer;
}

@property (nonatomic, weak) IBOutlet UIButton *browseButton;
@property (nonatomic, weak) IBOutlet UIButton *lastViewedButton;

@end

@implementation MainViewController

@synthesize browseButton, lastViewedButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    mediaPlayer = [[VLCMediaPlayer alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onBrowse:(id)sender {
    NSLog(@"browse");
}

-(IBAction)onLastViewed:(id)sender {
    NSLog(@"last viewed");
}

@end
