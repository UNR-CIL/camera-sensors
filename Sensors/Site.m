//
//  Site.m
//  Sensors
//
//  Created by John Jusayan on 2/26/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import "Site.h"
#import "Image.h"
#import "Region.h"

#import "NSManagedObject+SCEntityFetchOrInsert.h"

@implementation Site

@dynamic id;
@dynamic latitude;
@dynamic longitude;
@dynamic name;
@dynamic regionName;
@dynamic thumbnailImage;
@dynamic images;
@dynamic region;

+ (instancetype)siteFromDictionary:(NSDictionary*)siteDictionary inManagedObjectContext:(NSManagedObjectContext*)context
{
    Site *newSite = [self sc_entityFetchOrInsertForKey:@"id" withValue:[siteDictionary objectForKey:@"id"] inManagedObjectContext:context];
    newSite.name = [siteDictionary objectForKey:@"name"];
    newSite.id = [siteDictionary objectForKey:@"id"];
    return newSite;
}


@end
