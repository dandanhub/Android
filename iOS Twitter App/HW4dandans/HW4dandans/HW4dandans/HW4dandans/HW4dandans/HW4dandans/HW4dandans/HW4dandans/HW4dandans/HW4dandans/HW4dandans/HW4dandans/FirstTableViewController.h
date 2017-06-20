//
//  SecondTableTableViewController.h
//  iOSHW2
//
//  Created by Dandan Shi on 09/06/2017.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetEventViewController.h"

@interface FirstTableViewController : UITableViewController
//@property  NSMutableArray *events;
@property  NSArray *events;
@property  NSArray *eventDates;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) TweetEventViewController *detailViewController;
// @property (strong, nonatomic) NSPersistentStoreCoordinator *inMemoryStoreCoordinator;
@end
