//
//  UIImage+ColorImage.h
//  Codename CHOMPS
//
//  Created by Steven Brunwasser on 3/10/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Add the ability to create an image from a color.
@interface UIImage (ColorImage)

/// Create an image from the given color.
/// @param color The color to create the image from.
/// @return An image that is the color 
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
