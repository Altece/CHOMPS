//
//  MealViewController.m
//  Codename CHOMPS
//
//  Created by Piper Chester on 3/10/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import "MealViewController.h"

@interface MealViewController ()

@end

@implementation MealViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Meals";
    
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 200, 40)];
    [myLabel setBackgroundColor:[UIColor clearColor]];
    [myLabel setText:@"Breakfast"]; /// Will be passed in from external class
    [[self view] addSubview:myLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 80, 200, 200)];
    imageView = (UIImageView *)[imageView viewWithTag:0];
    imageView.image = [UIImage imageNamed:@"pizza.jpg"]; /// Will be passed in from external class
    [[self view] addSubview:imageView];
    
    
    UITextField *myTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 300, 300, 500)];
    [myTextField setBackgroundColor:[UIColor clearColor]];
    [myTextField setText:@"Notes: It tasted great!"]; /// Will be passed in from external class
    [[self view] addSubview:myTextField];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
