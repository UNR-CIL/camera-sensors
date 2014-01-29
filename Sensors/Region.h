//
//  Region.h
//  Sensors
//
//  Created by John Jusayan on 1/29/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Region : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSSet *sites;
@end

@interface Region (CoreDataGeneratedAccessors)

- (void)addSitesObject:(NSManagedObject *)value;
- (void)removeSitesObject:(NSManagedObject *)value;
- (void)addSites:(NSSet *)values;
- (void)removeSites:(NSSet *)values;

@end
