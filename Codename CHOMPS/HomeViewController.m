//
//  HomeViewController.m
//  Codename CHOMPS
//
//  Created by Michael Timbrook on 3/9/13.
//  Copyright (c) 2013 Codename CHOMPS. All rights reserved.
//

#import "HomeViewController.h"
#import "CameraViewController.h"
#import "HomeViewHeader.h"
#import "HomeViewCell.h"
#import "AppDelegate.h"

@interface HomeViewController ()

@end

static NSString *HOME_CELL = @"HomeViewCell";
static NSString *HOME_HEADER = @"HomeViewHeader";

@implementation HomeViewController

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
    
    NSDate *currentDate = [NSDate date];
    
    self.navigationItem.title = @"My Meals";
    
    // table view setup
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorColor = [UIColor blackColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // table resue registration
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeViewCell" bundle:nil] forCellReuseIdentifier:HOME_CELL];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeViewHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:HOME_HEADER];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/// Number of Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/// Number of Rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSManagedObjectContext *moc = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:@"Meal"];
    
    return 5;//[moc countForFetchRequest:req error:nil];
}

/// Get Cell for a given NSIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    HomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HOME_CELL];
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [HomeViewHeader height];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    switch (section) {
        case 0:
            title = @"My Meals";
            break;
            
        default:
            title = @"PIZZA! :D";
            break;
    }
    HomeViewHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HOME_HEADER];
    header.title.text = title;
    
    return header;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HomeViewCell height];
}

#pragma mark - Outlets

- (IBAction)launchCamera:(id)sender
{    
    [self performSegueWithIdentifier:@"cameraSegue" sender:nil];
}
@end
