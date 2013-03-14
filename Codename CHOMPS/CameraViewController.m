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
    NSOperationQueue *cameraSave;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    objectIDs = [[NSMutableArray alloc] init];
    takePicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takePicture:)];
    [self.view addGestureRecognizer:takePicture];
    doneTakingImages = NO;
    
    cameraSave = [[NSOperationQueue alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    if (doneTakingImages) {
        if (objectIDs.count > 0) {
            [self performSegueWithIdentifier:@"toImagePicker" sender:@"toImagePicker"];
        } else {
            [self performSegueWithIdentifier:@"returnSegue" sender:@"returnToMainView"];
        }
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
        
        shutter = [[UIView alloc] initWithFrame:CGRectMake(0, -self.view.frame.size.height - 22, self.view.frame.size.width, self.view.frame.size.height)];
        
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
    
    if ([sender isEqualToString:@"toImagePicker"]) {
        ImagePickerController *imagePicker = segue.destinationViewController;
        [imagePicker setTakenImageObjectID:objectIDs];
        NSLog(@"%d operations left", cameraSave.operationCount);
        [cameraSave waitUntilAllOperationsAreFinished]; // Blocking
    } else if ([sender isEqualToString:@"returnToMainView"]){
        
    }
}

- (void)doneWithCamera
{
    [camera dismissViewControllerAnimated:YES completion:nil];
    [_loadingActivity setHidden:NO];
    [_loadingText setHidden:NO];
    [_doneButton setHidden:YES];
}

- (void)resetWithImages:(NSMutableArray *)images
{
    
}

#pragma mark - Image Proccessing

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [cameraSave waitUntilAllOperationsAreFinished];
    if ([objectIDs count] >= 10) {
        [self doneWithCamera];
    }
    [cameraSave addOperationWithBlock:^{
    
        // Camera save IO
        NSLog(@"Saving");
        NSManagedObjectContext *MAP = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
        Image *imageStore = [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:MAP];
        [imageStore setImage:info[UIImagePickerControllerOriginalImage]];
        NSDate *timestamp = [NSDate dateWithTimeIntervalSinceNow:0];
        [imageStore setTimestamp:timestamp];
        [MAP save:nil];
        [objectIDs addObject:timestamp];
        NSLog(@"Saved");
        
     }];
    
    [UIView animateWithDuration:.1 animations:^{
        [shutter setFrame:CGRectMake(0, -self.view.frame.size.height - 22, self.view.frame.size.width, self.view.frame.size.height)];
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
