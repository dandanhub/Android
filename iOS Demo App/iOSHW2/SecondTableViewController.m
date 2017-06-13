//
//  SecondTableTableViewController.m
//  iOSHW2
//
//  Created by Dandan Shi on 09/06/2017.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import "SecondTableViewController.h"
#import "Event.h"
#import <CoreData/CoreData.h>
@interface SecondTableViewController ()

@end

@implementation SecondTableViewController

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
    self.title=@"PVGP Events";
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
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Event* event = [self.events objectAtIndex:indexPath.row];
    cell.textLabel.text = event.eventName;
    NSString *message = [event.eventTime stringByAppendingFormat:@"%@ %@", @" at: ", event.eventLocation];
    cell.detailTextLabel.text= message;
    
    
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
//        id delegate = [[UIApplication sharedApplication] delegate];
//        self.managedObjectContext = [delegate managedObjectContext];
        
        // ObjectModel from any models in app bundle
        NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        // Coordinator with in-mem store type
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
        [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:nil];
        
        // Context with private queue
        self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        self.managedObjectContext.persistentStoreCoordinator = coordinator;
        
        // use mutable array collection
        self.events = [[NSMutableArray alloc] init];
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
        
        // create event items
        Event * firstEvent = [NSEntityDescription insertNewObjectForEntityForName:[entityDescription name]
                                                inManagedObjectContext: self.managedObjectContext];
        [firstEvent setValue:@"Kick-Off Rally" forKey:@"eventName"];
        [firstEvent setValue:@"Sunday, July 2"  forKey:@"eventTime"];
        [firstEvent setValue:@"TBD" forKey:@"eventLocation"];
        
        Event * secondEvent = [NSEntityDescription insertNewObjectForEntityForName:[entityDescription name]
                                                    inManagedObjectContext: self.managedObjectContext];
        [secondEvent setValue:@"Blacktie & Tailpipes Gala" forKey:@"eventName"];
        [secondEvent setValue:@"July 7"  forKey:@"eventTime"];
        [secondEvent setValue:@"TBD" forKey:@"eventLocation"];
        
        Event * thirdEvent = [NSEntityDescription insertNewObjectForEntityForName:[entityDescription name]
                                                           inManagedObjectContext: self.managedObjectContext];
        [thirdEvent setValue:@"Historics at Pitt Race Weekend" forKey:@"eventName"];
        [thirdEvent setValue:@"July 7-9"  forKey:@"eventTime"];
        [thirdEvent setValue:@"Pittsburgh International Race Complex" forKey:@"eventLocation"];
        
        // save event items to mutable array collection
        [self.events addObject:firstEvent];
        [self.events addObject:secondEvent];
        [self.events addObject:thirdEvent];
        
        // sent out log
        NSLog(@"%@ %@ at: %@", firstEvent.eventName, firstEvent.eventTime, firstEvent.eventLocation);
        NSLog(@"%@ %@ at: %@", secondEvent.eventName, secondEvent.eventTime, secondEvent.eventLocation);
        NSLog(@"%@ %@ at: %@", thirdEvent.eventName, thirdEvent.eventTime, thirdEvent.eventLocation);

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

@end
