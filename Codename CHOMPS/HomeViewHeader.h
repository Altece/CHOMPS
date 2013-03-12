//
//  HomeViewHeader.h
//  Codename CHOMPS
//
//  Created by Steven Brunwasser on 3/10/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewHeader : UITableViewHeaderFooterView 

@property (weak, nonatomic) IBOutlet UILabel *title;

+ (CGFloat)height;

@end
