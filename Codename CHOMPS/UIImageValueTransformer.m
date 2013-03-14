//
//  ImageTransformer.m
//  Codename CHOMPS
//
//  Created by Steven Brunwasser on 3/9/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import "UIImageValueTransformer.h"

static UIImageValueTransformerQuiality imageQuality = UIImageValueTransformerQuialityHigh;

static NSString *IMAGES_FOLDER = @"MealImages";

static NSUInteger fileNumber = 0;

static NSString *GrabImagesFolder()
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:IMAGES_FOLDER];
}

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
        NSString *filename = [[@"Image " stringByAppendingFormat:@"%@ %d", [[NSDate date] description], fileNumber++] stringByAppendingPathExtension:@".jpg"];
        NSString *filePath = [GrabImagesFolder() stringByAppendingPathComponent:filename];
        
        NSData *data = UIImageJPEGRepresentation((UIImage *)value, compressionForImageQuality(imageQuality));
        
        [data writeToFile:filePath atomically:YES];
        
        return filename;
    }
    
    return nil;
}

- (id)reverseTransformedValue:(id)value
{
    if (value) {
        NSString *filename = value;
        NSString *filePath = [GrabImagesFolder() stringByAppendingPathComponent:filename];
        
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        return [UIImage imageWithData:data];
    }
    
    return nil;
}

@end
