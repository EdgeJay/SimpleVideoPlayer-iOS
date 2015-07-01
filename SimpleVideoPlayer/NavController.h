//
//  NavController.h
//  SimpleVideoPlayer
//
//  Created by Huijie Wu on 1/7/15.
//  Copyright (c) 2015 EdgeJay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavController : UINavigationController

/**
 * Call this method to return to MainViewController
 */
-(void)unwindToMain;

/**
 * Call this method to push in VideoPlayerViewController
 */
-(void)gotoVideoPlayer: (NSURL *)videoUrl;

@end
