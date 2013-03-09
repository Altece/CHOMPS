//
//  ImageTransformer.m
//  Codename CHOMPS
//
//  Created by Steven Brunwasser on 3/9/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import "UIImageValueTransformer.h"

static UIImageValueTransformerQuiality imageQuality = UIImageValueTransformerQuialityHigh;

/// A function to get the compression value for an
/// ImageTransformerQuality value
/// @param quality  The quality value.
/// @return The comression value for the ImageTransformerQuality
static CGFloat compressionForImageQuality(UIImageValueTransformerQuiality quality)
{
    switch (quality) {
        case UIImageValueTransformerQuialityHigh:
            return 1.0;
            
        case UIImageValueTransformerQuialityMedium:
            return 0.5;
            
        case UIImageValueTransformerQuialityLow:
            return 0.0;
            
        default:
            return 1.0;
    }
}

@implementation UIImageValueTransformer {
}

#pragma mark - Class methods for setting up the transformer's behavior

+ (BOOL)allowsReverseTransformation
{
    return YES;
}

+ (Class)transformedValueClass
{
    return [NSData class];
}

#pragma mark - get/set compression quality

+ (void)setImageQuality:(UIImageValueTransformerQuiality)quality
{
    imageQuality = quality;
}

+ (UIImageValueTransformerQuiality)imageQuality
{
    return imageQuality;
}

#pragma mark - transforming the data to and from the image

- (id)transformedValue:(id)value
{
    if (value) {
        if ([value isKindOfClass:[NSData class]]) {
            return value;
        }
        
        return UIImageJPEGRepresentation((UIImage *)value, compressionForImageQuality(imageQuality));
    }
    
    return nil;
}

- (id)reverseTransformedValue:(id)value
{
    if (value)
        return [UIImage imageWithData:(NSData *)value];
    
    return nil;
}

@end
