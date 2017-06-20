//
//  Event.h
//  iOSHW2
//
//  Created by Dandan Shi on 09/06/2017.
//  Copyright © 2017 CarnegieMellonUniversity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface Event : NSManagedObject
@property (nonatomic, retain) NSString *eventName;
@property (nonatomic, retain) NSString *eventTime;
@property (nonatomic, retain) NSString *eventLocation;

@end
