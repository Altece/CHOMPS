//
//  HomeViewCell.h
//  Codename CHOMPS
//
//  Created by Steven Brunwasser on 3/10/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"

/// This is a TableViewCell that represents an entry on the view.
@interface HomeViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;

@property (strong, nonatomic) Meal *meal;

/// The height for a cell at this position.
+ (CGFloat)height;

@end
