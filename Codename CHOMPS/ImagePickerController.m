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
#import "ImagePickerController.h"

@interface ImagePickerController ()

@end

@implementation ImagePickerController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _imageCollectionView.dataSource = self;
    _imageCollectionView.delegate = self;
    [_imageCollectionView setBackgroundColor:[UIColor whiteColor]];
    
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
    return [_takenImageObjectID count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:indexPath];
    
    // Core Data Fetch
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Image" inManagedObjectContext:app.managedObjectContext];
    request.predicate = [NSPredicate predicateWithFormat:@"(timestamp == %@)", (NSDate *)[_takenImageObjectID objectAtIndex:indexPath.row]];
    NSArray *data = [app.managedObjectContext executeFetchRequest:request error:nil];
    
    // Image NSManagedObject
    Image *imageStore = [data objectAtIndex:0];
    
    // Gets UIImage from imageStore and sets imageStore to nil
    UIImage *image = [imageStore image];
    imageStore = nil;
    
    // Creates a UIImage and sets old image to nil, should be creating thumbnail
    UIImage *thumb = [UIImage imageWithData:UIImageJPEGRepresentation(image, .1) scale:.1];
    image = nil;
    
    // Creates the ImageView from Image
    UIImageView *imageView = [[UIImageView alloc] initWithImage:thumb];
    
    // Sets it to the cells background view
    [cell setBackgroundView:imageView];
    
    return cell;
}


#pragma mark - IBActions

- (IBAction)saveSelectedImages:(id)sender {
}

- (IBAction)cancel:(id)sender {
}

- (IBAction)addMoreImages:(id)sender {
}
@end
