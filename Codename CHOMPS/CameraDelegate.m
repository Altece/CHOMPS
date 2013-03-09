//
//  CameraDelegate.m
//  Codename CHOMPS
//
//  Created by Michael Timbrook on 3/9/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import "CameraDelegate.h"

@implementation CameraDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Image from camera
    UIImage *takenImage = info[UIImagePickerControllerOriginalImage];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
}

@end
