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
    return _takenImageObjectID.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:indexPath];
    
    Image *img = _takenImageObjectID[indexPath.row];
    
    // Sets it to the cells background view
    [cell.image setImage:img.image];
    
    // Set cell date from image
    [cell setDate:img.timestamp];
    
    return cell;
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
    NSMutableArray *saveImages = [[NSMutableArray alloc] init]; // Array of timestamps
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
    NSManagedObjectContext *moc = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    Meal *meal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal" inManagedObjectContext:moc];

    [meal addImages:[NSSet setWithArray:saveImages]];

    NSLog(@"%@", meal.images);
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
