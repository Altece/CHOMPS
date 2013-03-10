//
//  ImagePickerCell.m
//  Codename CHOMPS
//
//  Created by Michael Timbrook on 3/10/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import "ImagePickerCell.h"

@implementation ImagePickerCell {
    
    UITapGestureRecognizer *tapToSelect;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    if (self.selectedForUse) {
        [_checkBox setAlpha:1.0];
    } else {
        [_checkBox setAlpha:0.2];
    }
    
}

@end
