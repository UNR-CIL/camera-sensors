//
//  Region.h
//  Sensors
//
//  Created by John Jusayan on 2/5/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Site;

@interface Region : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) id thumbnailImage;
@property (nonatomic, retain) NSSet *sites;

+ (instancetype)regionFromName:(NSString*)regionName inManagedObjectContext:(NSManagedObjectContext*)context;

@end

@interface Region (CoreDataGeneratedAccessors)

- (void)addSitesObject:(Site *)value;
- (void)removeSitesObject:(Site *)value;
- (void)addSites:(NSSet *)values;
- (void)removeSites:(NSSet *)values;

@end
