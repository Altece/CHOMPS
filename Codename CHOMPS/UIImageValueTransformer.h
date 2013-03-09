//
//  ImageTransformer.h
//  Codename CHOMPS
//
//  Created by Steven Brunwasser on 3/9/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    UIImageValueTransformerQuialityLow,
    UIImageValueTransformerQuialityMedium,
    UIImageValueTransformerQuialityHigh
} UIImageValueTransformerQuiality;

@interface UIImageValueTransformer : NSValueTransformer

/// Set the image compression quality to use.
/// @param quality  The quality to use for compression.
+ (void)setImageQuality:(UIImageValueTransformerQuiality)quality;

/// Get the current image quality.
/// @return The image quality currently being used.
+ (UIImageValueTransformerQuiality)imageQuality;

@end
