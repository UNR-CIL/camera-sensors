//
//  Region.m
//  Sensors
//
//  Created by John Jusayan on 2/26/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import "Region.h"
#import "Site.h"

#import "NSManagedObject+SCEntityFetchOrInsert.h"

@implementation Region

@dynamic id;
@dynamic latitude;
@dynamic longitude;
@dynamic name;
@dynamic thumbnailImage;
@dynamic sites;

+ (instancetype)regionFromName:(NSString*)regionName inManagedObjectContext:(NSManagedObjectContext*)context
{
    Region *newRegion = [self sc_entityFetchOrInsertForKey:@"id" withValue:regionName inManagedObjectContext:context];
    newRegion.name = regionName;
    newRegion.id = regionName;
    return newRegion;
}

@end
