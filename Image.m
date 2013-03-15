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
    NSString *images = documents; //[documents stringByAppendingPathComponent:IMAGES_FOLDER];
    
//    if (! [[NSFileManager defaultManager] fileExistsAtPath:images isDirectory:nil])
        [[NSFileManager defaultManager] createDirectoryAtPath:images withIntermediateDirectories:YES attributes:nil error:nil];
    
    return images;
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
        
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:filePath];
        
        return [UIImage imageWithData:data];
    }
    
    return nil;
}

- (void)setImage:(UIImage *)image
{
    NSString *timestamp = [[NSDate date] description];
    NSString *filename = [NSString stringWithFormat:@"%@.jpg", timestamp];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:filename];
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:savedImagePath atomically:NO];
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
