//
//  CameraViewController.h
//  Codename CHOMPS
//
//  Created by Michael Timbrook on 3/9/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingActivity;
@property (weak, nonatomic) IBOutlet UILabel *loadingText;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) NSMutableArray *capturedImages;


- (IBAction)isDoneTakingPictures:(id)sender;
- (void)resetWithImages:(NSMutableArray *)images;
@end
