//
//  SecondTableTableViewController.m
//  iOSHW2
//
//  Created by Dandan Shi on 09/06/2017.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "FirstTableViewController.h"
#import "Event.h"
#import <CoreData/CoreData.h>
@interface FirstTableViewController ()

@end

@implementation FirstTableViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    // Uncomment the following line to preserve selection between presentations.
//    // self.clearsSelectionOnViewWillAppear = NO;
//
//    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//}

/*
 2. The Second Tab
 
 View2: Display Event Lists (Data Source from using Collections)
 
 From the course example, Use Event Object (attributes: eventDate, eventLocation and eventName) for values assosiated to Keys (item0 -item9) to populate  in your collection objects and display events Date/Title in the Table View (iOS)
 
 You should send out each Event data to Console Output (lldb in iOS case, log cat in Android case) when you initialize Event data in the memory.
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    [self init];
    self.title=@"Tweet";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    // return 0;
    return _events.count;
    // NSLog(@"count %lu", (unsigned long)[_events count]);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"firstCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text =[_events objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=[_eventDates objectAtIndex:indexPath.row];
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(id)init
{
    self = [super init];
    if(self)
    {
        _events = @[@"Kick-Off Rallye",
                    @"Blacktie & Tailpipes Gala" ,
                    @"Historics at Pitt Race Weekend",
                    @"Walnut Street Car Show",
                    @"Waterfront Car Cruise",
                    @"Downtown Parade & Car Display",
                    @"Tune-Up Party @ Atria’s",
                    @"Countryside Tour",
                    @"Forbes Ave of Speed Race Car Parade",
                    @"Vintage Car Show & Car Races"];
        _eventDates = @[@"Sunday, July 2 at TBD",
                        @"July 7 at TBD" ,
                        @"July 7-9 at Pittsburgh International Race Complex",
                        @"Monday, July 10 at Walnut Street",
                        @"Tuesday, July 11 at Waterfront",
                        @"Wednesday, July 12 at Downtown",
                        @"Wednesday, July 12 at Downtown",
                        @"Thursday, July 13 at TBD",
                        @"Thursday, July 14 at Forbes avenue to Squirrel Hill",
                        
                        @"Weekend, July 15/16 at Schenley Park"];
    }
    return self;
}

//- (NSManagedObjectContext*) managedObjectContext
//{
//    // ObjectModel from any models in app bundle
//    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
//
//    // Coordinator with in-mem store type
//    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
//    [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:nil];
//
//    // Context with private queue
//    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
//    self.managedObjectContext.persistentStoreCoordinator = coordinator;
//
//    return self.managedObjectContext;
//}

// June 13
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"detail"]) {
        self.detailViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        // customize here
        // Event* event = [self.events objectAtIndex:indexPath.row];
         self.detailViewController.itemName = _events[indexPath.row];
         self.detailViewController.itemDate= _eventDates[indexPath.row];
//        self.detailViewController.itemName = event.eventName;
//        NSString *message = [event.eventTime stringByAppendingFormat:@"%@ %@", @" at: ", event.eventLocation];
//        self.detailViewController.itemDate = message;
        
    }
}

@end
