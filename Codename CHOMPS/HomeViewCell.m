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

static NSOperationQueue *imageCellImageLoaderQueue;

@implementation HomeViewCell {
    __strong UIImage *clearImage;
}

+ (void)initialize
{
    imageCellImageLoaderQueue = [[NSOperationQueue alloc] init];
    imageCellImageLoaderQueue.name = @"ImageCellImageLoaderQueue";
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
//    self.imageView4.image = clearImage;
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
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterLongStyle;
    df.timeStyle = NSDateFormatterShortStyle;
    self.timeLabel.text = [df stringFromDate:meal.timestamp];
    
    int count = meal.images.count;
    if (count > 3) count = 3;
    
    NSEnumerator *imgs = [meal.images objectEnumerator];
    
    [imageCellImageLoaderQueue addOperationWithBlock:^{
        UIImage *i1, *i2, *i3;
        
        switch (count) {
            case 0:
                return;
                
            case 3:
                i3 = [(Image *)[imgs nextObject] image];
            case 2:
                i2 = [(Image *)[imgs nextObject] image];
            case 1:
                i1 = [(Image *)[imgs nextObject] image];
                break;
                
            default:
                break;
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            switch (count) {
                case 0:
                    return;
                    
                case 3:
                    self.imageView3.image = i3;
                case 2:
                    self.imageView2.image = i2;
                case 1:
                    self.imageView1.image = i1;
                    break;
                    
                default:
                    break;
            }
        }];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)height
{
    return 150;
}

@end
