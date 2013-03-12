//
//  Meal.h
//  Codename CHOMPS
//
//  Created by Michael Timbrook on 3/11/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image;

@interface Meal : NSManagedObject

@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSNumber * mealType;
@property (nonatomic, retain) NSSet *images;
@end

@interface Meal (CoreDataGeneratedAccessors)

- (void)addImagesObject:(Image *)value;
- (void)removeImagesObject:(Image *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

@end
