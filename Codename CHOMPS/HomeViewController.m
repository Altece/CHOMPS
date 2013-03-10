//
//  HomeViewController.m
//  Codename CHOMPS
//
//  Created by Michael Timbrook on 3/9/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import "HomeViewController.h"
#import "CameraViewController.h"
#import "MealViewController.h"

@interface HomeViewController ()



@end

@implementation HomeViewController

NSMutableArray *pictureDates; /// Contains the timestamps of all pictures

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    pictureDates = [[NSMutableArray alloc] init]; /// Initializing the array
     
    [pictureDates addObject:@"March, 8th"];
    [pictureDates addObject:@"March, 10th"];
    [pictureDates addObject:@"March, 11th"];
    
    self.navigationItem.title = @"CHOMPS";

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return pictureDates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"Cell";    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
    }
    
    // Set up the cell...
    NSString *cellValue = [pictureDates objectAtIndex:indexPath.row];
    
    cell.text = cellValue;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self performSegueWithIdentifier:@"mealSegue" sender:nil]; /// Segue to MealViewController
    
}

#pragma mark - Outlets

- (IBAction)launchCamera:(id)sender
{    
    [self performSegueWithIdentifier:@"cameraSegue" sender:nil];
}

@end
