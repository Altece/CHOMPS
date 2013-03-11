//
//  ImagePickerController.h
//  Codename CHOMPS
//
//  Created by Michael Timbrook on 3/9/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePickerController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property (weak, nonatomic) NSMutableArray *takenImageObjectID;
- (IBAction)saveSelectedImages:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)addMoreImages:(id)sender;

@end
