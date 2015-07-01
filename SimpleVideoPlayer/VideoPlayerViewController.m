//
//  VideoPlayerViewController.m
//  SimpleVideoPlayer
//
//  Created by Wu Huijie on 1/7/15.
//  Copyright (c) 2015 EdgeJay. All rights reserved.
//

#import "VideoPlayerViewController.h"

@interface VideoPlayerViewController ()

@end

@implementation VideoPlayerViewController

@synthesize videoUrl;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    
}

-(void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden: YES animated: YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
