//
//  HomeViewController.h
//  Codename CHOMPS
//
//  Created by Michael Timbrook on 3/9/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface HomeViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    CMMotionManager *motionManager;
}

@property (nonatomic, retain) NSIndexPath *checkedIndexPath;
@property (nonatomic, retain) CMMotionManager *motionManager;

- (IBAction)launchCamera:(id)sender;

@end


