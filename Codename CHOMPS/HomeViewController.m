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
    /// A controller to manage CoreData info on a table view.
    __strong NSFetchedResultsController *frc;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;



@end

@implementation HomeViewController

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
        
//        [self scheduleUpdate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Codename CHOMPS";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    /// CoreData stuff
    NSManagedObjectContext *moc = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:@"Meal"];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO]];
    frc = [[NSFetchedResultsController alloc] initWithFetchRequest:req managedObjectContext:moc sectionNameKeyPath:nil cacheName:@"Root"];
    frc.delegate = self;
    
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
    id sectionInfo = [[frc sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[HomeViewCell class]]) {
        HomeViewCell *c = (HomeViewCell *)cell;
        Meal *meal = [frc objectAtIndexPath:indexPath];
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

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self performSegueWithIdentifier:@"mealSegue" sender:nil]; /// Segue to MealViewController
    
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
