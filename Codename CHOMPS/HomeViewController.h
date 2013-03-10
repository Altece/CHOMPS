//
//  HomeViewController.h
//  Codename CHOMPS
//
//  Created by Michael Timbrook on 3/9/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UITableViewController
@property (nonatomic, retain) NSIndexPath* checkedIndexPath;

- (IBAction)launchCamera:(id)sender;

@end


