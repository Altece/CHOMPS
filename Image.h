//
//  Image.h
//  Codename CHOMPS
//
//  Created by Steven Brunwasser on 3/14/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum : NSUInteger {
    SavedImageQuialityLow,
    SavedImageQuialityMedium,
    SavedImageQuialityHigh
} SavedImageQuiality;

@interface Image : NSManagedObject

@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * imagePath;

- (UIImage *)image;
- (void)setImage:(UIImage *)image;

+ (void)setImageQuality:(SavedImageQuiality)quality;
+ (SavedImageQuiality)imageQuality;

@end
