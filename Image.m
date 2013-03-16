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
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imagesPath = [documents stringByAppendingPathComponent:IMAGES_FOLDER];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (![[NSFileManager defaultManager] fileExistsAtPath:imagesPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:imagesPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    });
    
    return imagesPath;
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

@dynamic timestamp;
@dynamic imagePath;

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
    if (![filename isEqualToString:DEFAULT_STRING]) {
        NSString *filePath = [GrabImagesFolder() stringByAppendingPathComponent:filename];
        return [UIImage imageWithContentsOfFile:filePath];
    }
    
    return nil;
}

- (void)setImage:(UIImage *)image
{
    [self deleteImage];
    if (image) {
        NSString *filename = [NSString stringWithFormat:@"Image - %@ %d.jpg", [[NSDate date] description], fileNumber++];
        NSString *savedImagePath = [GrabImagesFolder() stringByAppendingPathComponent:filename];
        NSData *imageData = UIImageJPEGRepresentation(image, compressionForImageQuality(imageQuality));
        [imageData writeToFile:savedImagePath atomically:NO];
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
        NSString *savedImagePath = [GrabImagesFolder() stringByAppendingPathComponent:filename];
        [[NSFileManager defaultManager] removeItemAtPath:savedImagePath error:nil];
    }
}

- (void)prepareForDeletion
{
    [self deleteImage];
    [self setImagePath:DEFAULT_STRING];
    [super prepareForDeletion];
}

@end
