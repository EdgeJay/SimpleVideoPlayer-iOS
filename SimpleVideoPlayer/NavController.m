//
//  NavController.m
//  SimpleVideoPlayer
//
//  Created by Huijie Wu on 1/7/15.
//  Copyright (c) 2015 EdgeJay. All rights reserved.
//

#import "NavController.h"

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

@end
