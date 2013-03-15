//
//  Image.m
//  Codename CHOMPS
//
//  Created by Steven Brunwasser on 3/9/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import "Image.h"

static SavedImageQuiality imageQuality = SavedImageQuialityHigh;

static NSString *IMAGES_FOLDER = @"Images";

static NSString *DEFAULT_STRING = @"nil";

static NSUInteger fileNumber = 0;

static NSString *GrabImagesFolder()
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:IMAGES_FOLDER];
}

/// A function to get the compression value for an
/// ImageTransformerQuality value
/// @param quality  The quality value.
/// @return The comression value for the ImageTransformerQuality
static CGFloat compressionForImageQuality(SavedImageQuiality quality)
{
    switch (quality) {
        case SavedImageQuialityHigh:
            return 1.0;
            
        case SavedImageQuialityMedium:
            return 0.5;
            
        case SavedImageQuialityLow:
            return 0.0;
            
        default:
            return 1.0;
    }
}

@interface Image ()

- (void)deleteImage;

@end


@implementation Image

@dynamic image;
@dynamic imagePath;
@dynamic timestamp;

#pragma mark - get/set compression quality

+ (void)setImageQuality:(SavedImageQuiality)quality
{
    imageQuality = quality;
}

+ (SavedImageQuiality)imageQuality
{
    return imageQuality;
}

#pragma mark - transforming the data to and from the image

- (UIImage *)image
{
    NSString *filename = [self imagePath];
    if ([filename isEqualToString:DEFAULT_STRING]) {
        NSString *filePath = [GrabImagesFolder() stringByAppendingPathComponent:filename];
        
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        return [UIImage imageWithData:data];
    }
    
    return nil;
}

- (void)setImage:(UIImage *)image
{
    [self deleteImage];
    
    if (image) {
        NSString *filename = [[@"Image " stringByAppendingFormat:@"%@ %d", [[NSDate date] description], fileNumber++] stringByAppendingPathExtension:@".jpg"];
        NSString *filePath = [GrabImagesFolder() stringByAppendingPathComponent:filename];
        
        NSData *data = UIImageJPEGRepresentation(image, compressionForImageQuality(imageQuality));
        
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
//        [data writeToFile:filePath atomically:YES];
        
        [self setImagePath:filename];
    } else {
        [self setImagePath:DEFAULT_STRING];
    }
}

#pragma mark - Deleting Things

- (void)deleteImage
{
    NSString *filename = [self imagePath];
    if (![filename isEqualToString:DEFAULT_STRING]) {
        NSString *filePath = [GrabImagesFolder() stringByAppendingPathComponent:filename];
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}

- (void)prepareForDeletion
{
    [self deleteImage];
    [self setImagePath:DEFAULT_STRING];
    [super prepareForDeletion];
}

@end
