//
//  CameraViewController.m
//  Codename CHOMPS
//
//  Created by Michael Timbrook on 3/9/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Image.h"
#import "AppDelegate.h"
#import "CameraViewController.h"
#import "ImagePickerController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController {
    UIImagePickerController *camera;
    UITapGestureRecognizer *takePicture;
    NSMutableArray *objectIDs;
    BOOL doneTakingImages;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    objectIDs = [[NSMutableArray alloc] init];
    takePicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takePicture:)];
    [self.view addGestureRecognizer:takePicture];
    doneTakingImages = NO;
    
}

- (void)viewDidAppear:(BOOL)animated {
    if (doneTakingImages) {
        [self performSegueWithIdentifier:@"toImagePicker" sender:nil];
    } else {
        camera = [[UIImagePickerController alloc] init];
        [camera setSourceType:UIImagePickerControllerSourceTypeCamera];
        [camera setDelegate:self];
        [camera setShowsCameraControls:NO];
        [camera setWantsFullScreenLayout:YES];
        camera.cameraOverlayView = self.view;
        [camera setCameraCaptureMode:UIImagePickerControllerCameraCaptureModePhoto];
        [self presentViewController:camera animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    ImagePickerController *imagePicker = segue.destinationViewController;
    
    [imagePicker setTakenImageObjectID:objectIDs];
    
}

#pragma mark - Image Proccessing

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    Image *imageStore = [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:app.managedObjectContext];
    
    [imageStore setImage:info[UIImagePickerControllerOriginalImage]];
    
    NSDate *timestamp = [NSDate dateWithTimeIntervalSinceNow:0];
    
    [imageStore setTimestamp:timestamp];
    
     
    [app.managedObjectContext save:nil];
    
    [objectIDs addObject:timestamp];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
}

#pragma mark - Camera Actions

- (void)takePicture:(UITapGestureRecognizer *)reg
{
    [camera takePicture];
    
}

- (IBAction)isDoneTakingPictures:(id)sender
{
    doneTakingImages = YES;
    [camera dismissViewControllerAnimated:NO completion:nil];
}
@end
