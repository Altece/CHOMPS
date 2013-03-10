//
//  ImagePickerController.m
//  Codename CHOMPS
//
//  Created by Michael Timbrook on 3/9/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

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

#pragma Mark - datasource/delegate methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_takenImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:indexPath];
    UIImage *image = [[_takenImages objectAtIndex:indexPath.row] objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    [cell setBackgroundView:imageView];
    
    return cell;
}


#pragma Mark - IBActions

- (IBAction)saveSelectedImages:(id)sender {
}

- (IBAction)cancel:(id)sender {
}

- (IBAction)addMoreImages:(id)sender {
}
@end
