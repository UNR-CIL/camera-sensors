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
@dynamic altitude;
@dynamic latitude;
@dynamic longitude;
@dynamic name;
@dynamic thumbnailImage;
@dynamic sites;

+ (instancetype)regionFromDictionary:(NSDictionary*)regionDictionary inManagedObjectContext:(NSManagedObjectContext*)context
{
    Region *newRegion = [self sc_entityFetchOrInsertForKey:@"id" withValue:[regionDictionary objectForKey:@"id"] inManagedObjectContext:context];
    newRegion.name = [regionDictionary objectForKey:@"display_name"];
    newRegion.id = [regionDictionary objectForKey:@"id"];
    newRegion.altitude = [regionDictionary objectForKey:@"altitude"];
    newRegion.latitude = [regionDictionary objectForKey:@"latitude"];
    newRegion.longitude = [regionDictionary objectForKey:@"longitude"];

    return newRegion;
}

@end
