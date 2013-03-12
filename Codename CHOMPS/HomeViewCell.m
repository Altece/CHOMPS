//
//  HomeViewCell.m
//  Codename CHOMPS
//
//  Created by Steven Brunwasser on 3/10/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import "HomeViewCell.h"
#import "UIImage+ColorImage.h"
#import "Image.h"

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

- (void)setMeal:(Meal *)meal
{
    _meal = meal;
    self.timeLabel.text = [NSString stringWithFormat:@" %@", meal.timestamp];
    
    int count = meal.images.count;
    if (count > 4) count = 4;
    
    NSEnumerator *imgs = [meal.images objectEnumerator];
    
    switch (count) {
        case 0:
            return;
            
        case 4:
            self.imageView4.image = [(Image *)[imgs nextObject] image];
        case 3:
            self.imageView3.image = [(Image *)[imgs nextObject] image];
        case 2:
            self.imageView2.image = [(Image *)[imgs nextObject] image];
        case 1:
            self.imageView1.image = [(Image *)[imgs nextObject] image];
            break;
            
        default:
            break;
    }
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
