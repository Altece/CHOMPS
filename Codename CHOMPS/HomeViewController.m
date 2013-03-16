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

static NSString *HOME_CELL = @"HomeViewCell";
static NSString *HOME_HEADER = @"HomeViewHeader";

@interface HomeViewController () {
    NSManagedObjectContext *moc;
    __strong NSArray *meals;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;



@end

@implementation HomeViewController

@synthesize motionManager = motionManager;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    
    // Core Motion Initialization
    self.motionManager = [[CMMotionManager alloc] init];
    motionManager.deviceMotionUpdateInterval = 1.0/60.0;
    if (motionManager.isDeviceMotionAvailable){
        [motionManager startDeviceMotionUpdates];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"CHOMPS";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    /// CoreData stuff
    moc = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    [self updateMeals];
    
    // table view setup
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorColor = [UIColor blackColor];
    
    // table delegate setup
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // table resue registration
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeViewCell" bundle:nil] forCellReuseIdentifier:HOME_CELL];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeViewHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:HOME_HEADER];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self updateMeals];
    [super viewDidAppear:animated];
}

- (void)dealloc
{
    meals = nil;
    moc = nil;
}

- (void)updateMeals
{
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:@"Meal"];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO]];
    
    meals = [moc executeFetchRequest:req error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source

/// Number of Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/// Number of Rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [meals count];
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[HomeViewCell class]]) {
        HomeViewCell *c = (HomeViewCell *)cell;
        Meal *meal = meals[indexPath.row];
        c.meal = meal;        
    }
}

/// Get Cell for a given NSIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    HomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HOME_CELL];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

/// Get the height of the Headers
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [HomeViewHeader height];
}

/// Get the header view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    switch (section) {
        case 0:
            title = @"My Meals";//[[NSDate date] description];
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
    
//    [self performSegueWithIdentifier:@"mealSegue" sender:nil]; /// Segue to MealViewController
    
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

#pragma mark - CoreMotion 

- (void)update:(NSInteger)delta{
    // Get Motion Update
    
    CMDeviceMotion *currentDeviceMotion = motionManager.deviceMotion;
    CMAttitude *currentAttitude = currentDeviceMotion.attitude;
    
    float roll = currentAttitude.roll;
    float pitch = currentAttitude.pitch;
    float yaw = currentAttitude.yaw;
    
    NSLog(@"Roll:%.2f Pitch:%.2f Yaw:%.2f", roll, pitch, yaw);
}

@end
