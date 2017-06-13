//
//  ThirdTableViewController.h
//  iOSHW2
//
//  Created by Dandan Shi on 09/06/2017.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AddViewController.h"
@interface ThirdTableViewController :
UITableViewController<NSFetchedResultsControllerDelegate>
//CoreData
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) BOOL
suspendAutomaticTrackingOfChangesInManagedObjectContext;
- (void)insertNewObjectEventName:(NSString *)eventName
                       eventTime:(NSString *)eventTime eventLocation:(NSString
                                                                      *)eventLocation;
@end
