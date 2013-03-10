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

@implementation ImagePickerController {
    
    NSMutableArray *allImages;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _imageCollectionView.dataSource = self;
    _imageCollectionView.delegate = self;
    [_imageCollectionView setBackgroundColor:[UIColor whiteColor]];
    
    
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
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:indexPath];
    
    // Sets it to the cells background view
    [cell setBackgroundView:allImages[indexPath.row]];
    
    return cell;
}

- (NSMutableArray *)loadImageViewWithTimestampAfter:(NSDate *)start andBefore:(NSDate *)end
{
    // Core Data Fetch
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Image" inManagedObjectContext:app.managedObjectContext];
    request.predicate = [NSPredicate predicateWithFormat:@"(timestamp >= %@ && timestamp =< %@)", start, end];
    NSArray *data = [app.managedObjectContext executeFetchRequest:request error:nil];
    
    NSMutableArray *dataImages = [[NSMutableArray alloc] initWithCapacity:data.count];

    for (Image *imageStore in data) {
        
        // Gets UIImage from imageStore and sets imageStore to nil
        UIImage *image = [imageStore image];
        
        // Creates a UIImage and sets old image to nil, should be creating thumbnail
        UIImage *thumb = [UIImage imageWithData:UIImageJPEGRepresentation(image, .1) scale:.1];
        
        // Creates the ImageView from Image
        UIImageView *imageView = [[UIImageView alloc] initWithImage:thumb];
        
        // Add to array
        [dataImages addObject:imageView];
        
    }
    return dataImages;
}

#pragma mark - IBActions

- (IBAction)saveSelectedImages:(id)sender {
}

- (IBAction)cancel:(id)sender {
}

- (IBAction)addMoreImages:(id)sender {
}
@end
