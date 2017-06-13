//
//  AppDelegate.h
//  iOSHW2
//
//  Created by Dandan Shi on 09/06/2017.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

///// Core Data
@property (readonly, strong, nonatomic)
NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic)
NSManagedObjectModel *managedObjectModel;
@property (readonly,strong, nonatomic)
NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

