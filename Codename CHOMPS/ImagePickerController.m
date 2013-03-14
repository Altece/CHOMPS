//
//  ImagePickerController.m
//  Codename CHOMPS
//
//  Created by Michael Timbrook on 3/9/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Image.h"
#import "Meal.h"
#import "ImagePickerController.h"
#import "ImagePickerCell.h"
#import "CameraViewController.h"

@interface ImagePickerController ()

@end

@implementation ImagePickerController {
    
    NSMutableArray *allImages;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _imageCollectionView.dataSource = self;
    _imageCollectionView.delegate = self;
    
    // Load Images to array
    
    allImages = [self loadImageViewWithTimestampAfter:_takenImageObjectID[0] andBefore:[_takenImageObjectID lastObject]];
    
}

- (void)viewDidAppear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - datasource/delegate methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [allImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:indexPath];
    
    // Sets it to the cells background view
    [cell.image setImage:allImages[indexPath.row]];
    
    // Set cell date from image
    [cell setDate:_takenImageObjectID[indexPath.row]];
    
    return cell;
}

- (NSMutableArray *)loadImageViewWithTimestampAfter:(NSDate *)start andBefore:(NSDate *)end
{
    // Core Data Fetch
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Image" inManagedObjectContext:app.managedObjectContext];
    request.predicate = [NSPredicate predicateWithFormat:@"(timestamp >= %@ && timestamp =< %@)", start, end];
    NSError *error;
    
    NSArray *data = [app.managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
    
    NSMutableArray *dataImages = [[NSMutableArray alloc] initWithCapacity:data.count];

    for (Image *imageStore in data) {
        
        // Gets UIImage from imageStore and sets imageStore to nil
        UIImage *image = [imageStore image];
        
        // Creates a UIImage and sets old image to nil, should be creating thumbnail
        UIImage *thumb = [UIImage imageWithData:UIImageJPEGRepresentation(image, .1) scale:.1];
        
        // Add to array
        [dataImages addObject:thumb];
        
    }
    return dataImages;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImagePickerCell *cell = (ImagePickerCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [cell setSelectedForUse:!cell.selectedForUse];
    
    [cell setNeedsDisplay];
}

#pragma mark - IBActions

- (IBAction)saveSelectedImages:(id)sender
{
    
    NSLog(@"Done Called");
    
    // Sort images
    NSMutableArray *saveImages = [[NSMutableArray alloc] init];
    NSMutableArray *removeImages = [[NSMutableArray alloc] init];
    
    for (int i=0; i < allImages.count; i++) {
        ImagePickerCell *cell = (ImagePickerCell *)[_imageCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        if (cell.selectedForUse) {
            // Save to meal
            [saveImages addObject:cell.date];
        } else {
            // Remove from core data
            [removeImages addObject:cell.date];
        }
        
    }
    
    NSLog(@"Keep and add to meal\n%@", saveImages);
    NSLog(@"Remove\n%@", removeImages);

    // Create Meal

    NSManagedObjectContext *mop = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    Meal *imageStore = [NSEntityDescription insertNewObjectForEntityForName:@"Meal" inManagedObjectContext:mop];

    [imageStore setImages:[NSSet setWithArray:saveImages]];

    NSLog(@"%@", imageStore.images);


}

- (IBAction)cancel:(id)sender {
}

- (IBAction)addMoreImages:(id)sender
{
    [self performSegueWithIdentifier:@"returnToCamera" sender:_takenImageObjectID];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([(NSMutableArray *)sender count] == _takenImageObjectID.count) {
        
        NSLog(@"?");
        
    }
    
}










@end
