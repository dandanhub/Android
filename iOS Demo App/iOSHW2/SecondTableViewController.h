//
//  SecondTableTableViewController.h
//  iOSHW2
//
//  Created by Dandan Shi on 09/06/2017.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondTableViewController : UITableViewController
@property  NSMutableArray *events;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
// @property (strong, nonatomic) NSPersistentStoreCoordinator *inMemoryStoreCoordinator;
@end
