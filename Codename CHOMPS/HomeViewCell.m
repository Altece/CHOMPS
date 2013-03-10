//
//  HomeViewCell.m
//  Codename CHOMPS
//
//  Created by Steven Brunwasser on 3/10/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import "HomeViewCell.h"
#import "UIImage+ColorImage.h"

@implementation HomeViewCell {
    __strong UIImage *clearImage;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    clearImage = [UIImage imageWithColor:[UIColor clearColor]];
    self.imageView1.image = clearImage;
    self.imageView2.image = clearImage;
    self.imageView3.image = clearImage;
    self.imageView4.image = clearImage;
}

- (void)setup
{
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)dealloc
{
    clearImage = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)height
{
    return 100;
}

@end
