//
//  CameraViewController.h
//  Codename CHOMPS
//
//  Created by Michael Timbrook on 3/9/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (IBAction)takePicture:(id)sender;
- (IBAction)isDoneTakingPictures:(id)sender;
 
@end