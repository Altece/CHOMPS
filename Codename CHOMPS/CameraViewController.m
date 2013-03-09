//
//  CameraViewController.m
//  Codename CHOMPS
//
//  Created by Michael Timbrook on 3/9/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController {
    UIImagePickerController *camera;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated {
    camera = [[UIImagePickerController alloc] init];
    [camera setSourceType:UIImagePickerControllerSourceTypeCamera];
    [camera setDelegate:self];
    [camera setShowsCameraControls:NO];
    
    camera.cameraOverlayView = self.view;
    
    [camera setCameraCaptureMode:UIImagePickerControllerCameraCaptureModePhoto];
    [self presentViewController:camera animated:animated completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Image Proccessing

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@", info);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
}

#pragma mark - Camera Actions

- (IBAction)takePicture:(id)sender {
    [camera takePicture];
}


- (IBAction)isDoneTakingPictures:(id)sender {
    [self performSegueWithIdentifier:@"toImagePicker" sender:nil];
}
@end
