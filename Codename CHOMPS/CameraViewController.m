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
    UIView *shutter;
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
        doneTakingImages = YES;
        [self presentViewController:camera animated:NO completion:nil];
        
        shutter = [[UIView alloc] initWithFrame:CGRectMake(0, -self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
        
        [shutter setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:shutter];
        [self.view bringSubviewToFront:shutter];
        
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

- (void)doneWithCamera
{
    [camera dismissViewControllerAnimated:YES completion:nil];
    [_loadingActivity setHidden:NO];
    [_loadingText setHidden:NO];
    [_doneButton setHidden:YES];
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
    
    if ([objectIDs count] >= 9) {
        [self doneWithCamera];
    }
    
    [UIView animateWithDuration:.1 animations:^{
        [shutter setFrame:CGRectMake(0, -self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
}

#pragma mark - Camera Actions

- (void)takePicture:(UITapGestureRecognizer *)reg
{
    [UIView animateWithDuration:.1 animations:^{
        [shutter setFrame:CGRectMake(0, -96, self.view.frame.size.width, self.view.frame.size.height)];
    }];
    [camera takePicture];
}

- (IBAction)isDoneTakingPictures:(id)sender
{
    [self doneWithCamera];
}
@end
