//
//  CoreMotionManger.m
//  Codename CHOMPS
//
//  Created by Michael Timbrook on 3/15/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import "CoreMotionStuff.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "CameraViewController.h"

@implementation CoreMotionStuff {
    
    AppDelegate *app;
}

- (id)init
{
    self = [super init];
    if (self){
        app = [UIApplication sharedApplication].delegate;
        [self setUpMotion];
    }
    return self;
}

- (void)setUpMotion
{

    CMMotionManager *motionManager = [app sharedManager];
    _coreMotionQueue = [[NSOperationQueue alloc] init];
    
    
    void (^__block pushMotion)(CMDeviceMotion *, NSError *) = ^(CMDeviceMotion *motion, NSError *error) {
        if (motion.rotationRate.x < -10){
            NSLog(@"Motion");
            [motionManager stopDeviceMotionUpdates];
            [_coreMotionQueue cancelAllOperations];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self presentCameraIfNotAlreadyPresented];
            }];
            sleep(1);
            [motionManager startDeviceMotionUpdatesToQueue:_coreMotionQueue withHandler:pushMotion];
        } else if (motion.rotationRate.x > 8){
            NSLog(@"Un-Motion");
            [motionManager stopDeviceMotionUpdates];
            [_coreMotionQueue cancelAllOperations];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                NSLog(@"Test");
                [self dismissCamera];
            }];
            sleep(1);
            [motionManager startDeviceMotionUpdatesToQueue:_coreMotionQueue withHandler:pushMotion];
        }
    };
    
    
    [motionManager startDeviceMotionUpdatesToQueue:_coreMotionQueue withHandler:pushMotion];
    
    [motionManager setDeviceMotionUpdateInterval:.1];
    NSLog(@"%@", motionManager.deviceMotionAvailable ? @"YES" : @"NO");
    NSLog(@"%@", motionManager.deviceMotionActive ? @"YES" : @"NO");
    
}

- (void)presentCameraIfNotAlreadyPresented
{
    if (![app.window.rootViewController isKindOfClass:[CameraViewController class]]){

        UIStoryboard *story = [UIStoryboard storyboardWithName:@"iPhoneMainStoryboard" bundle:nil];
        HomeViewController *hvc = [story instantiateViewControllerWithIdentifier:@"Home"];
        [app.window.rootViewController presentViewController:hvc animated:NO completion:nil];
        [hvc performSegueWithIdentifier:@"cameraSegue" sender:nil];
    }
}

- (void)dismissCamera {
    CameraViewController *camera = app.window.rootViewController;
    if([camera respondsToSelector:@selector(isDoneTakingPictures:)]){
        [camera isDoneTakingPictures:nil];
        NSLog(@"Success");
    } else {
        NSLog(@"Did not respond : %@", [app.window.rootViewController class]);
    }
}

@end
