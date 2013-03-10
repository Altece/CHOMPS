//
//  HomeViewHeader.m
//  Codename CHOMPS
//
//  Created by Steven Brunwasser on 3/10/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import "HomeViewHeader.h"
#import "UIImage+ColorImage.h"

@implementation HomeViewHeader {
    __strong UIImageView *backgroundView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:[UIColor blackColor]]];
    backgroundView.alpha = .5;
    [self setBackgroundView:backgroundView];
}

+ (CGFloat)height
{
    return 42;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
