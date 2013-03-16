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
#import "HomeViewController.h"

@interface ImagePickerController ()

@end

@implementation ImagePickerController {
    
    
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
    cell.image = img.image;
    
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
    NSMutableSet *setOfImages;
    
    NSLog(@"Done Called");
    
    NSManagedObjectContext *moc = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    
    // Sort images
    NSMutableArray *saveImages = [[NSMutableArray alloc] init]; // Array of timestamps
    
    // Going through all images and adding the objects at idices
    for (int i=0; i< _takenImageObjectID.count; i++) {
        ImagePickerCell *cell = (ImagePickerCell *)[_imageCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        Image *tmp = _takenImageObjectID[i];
        if (cell.selectedForUse) {
            // Save to meal
            [saveImages addObject:tmp];
        } else {
            [moc deleteObject:tmp];
        }
        
    }


    // Create Meal
    Meal *meal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal" inManagedObjectContext:moc];
    
    [meal addImages:[NSSet setWithArray:saveImages]];
    [meal setTimestamp:[NSDate date]];
    
    NSLog(@"%@", meal.images);
    
    if ([saveImages count] < 1){
        [moc save:nil];
    }
    
    [self cancel:nil];
}

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addMoreImages:(id)sender
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{    
    
}










@end
