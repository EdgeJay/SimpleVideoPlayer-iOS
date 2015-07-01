//
//  NavController.m
//  SimpleVideoPlayer
//
//  Created by Huijie Wu on 1/7/15.
//  Copyright (c) 2015 EdgeJay. All rights reserved.
//

#import "NavController.h"
#import "VideoPlayerViewController.h"

@interface NavController ()

@end

@implementation NavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * Instructs nav controller to return to main view controller
 */
-(void)unwindToMain {
    [[self presentingViewController] dismissViewControllerAnimated: YES completion: nil];
}

-(void)gotoVideoPlayer: (NSString *)videoPath {
    
    if (!videoPath) {
        NSLog(@"oops missing video path");
        return;
    }
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier: @"VideoPlayerVC"];
    
    [(VideoPlayerViewController *)vc setVideoPath: videoPath];
    
    [self pushViewController: vc animated: YES];
}

@end
