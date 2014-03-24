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
@dynamic alias;
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
    newSite.name = [siteDictionary objectForKey:@"display_name"];
    newSite.id = [siteDictionary objectForKey:@"id"];
    newSite.alias = [siteDictionary objectForKey:@"alias"];
    newSite.latitude = [siteDictionary objectForKey:@"latitude"];
    newSite.longitude = [siteDictionary objectForKey:@"longitude"];
    
    return newSite;
}


@end
