//
//  ImagePickerCell.h
//  Codename CHOMPS
//
//  Created by Michael Timbrook on 3/10/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePickerCell : UICollectionViewCell
@property (strong, nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *checkBox;
@property (weak, nonatomic) NSDate *date;

@property BOOL selectedForUse;

@end
