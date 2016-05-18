//
//  Site.m
//  GB SciCam
//
//  Created by John Jusayan on 1/17/16.
//  Copyright © 2016 Treeness, LLC. All rights reserved.
//

#import "Site.h"
#import "Image.h"
#import "Project.h"
#import "NSManagedObject+SCEntityFetchOrInsert.h"

@implementation Site

// Insert code here to add functionality to your managed object subclass

+ (instancetype)siteFromDictionary:(NSDictionary*)siteDictionary inManagedObjectContext:(NSManagedObjectContext*)context
{
    Site *newSite = [self sc_entityFetchOrInsertForKey:@"id" withValue:[siteDictionary objectForKey:@"ID"] inManagedObjectContext:context];
    
    newSite.alias = [siteDictionary objectForKey:@"Alias"];
    newSite.altitude = [siteDictionary objectForKey:@"Altitude"];
    newSite.id = [siteDictionary objectForKey:@"ID"];

    newSite.latitude = [siteDictionary objectForKey:@"Latitude"];
    newSite.longitude = [siteDictionary objectForKey:@"Longitude"];
    newSite.name = [siteDictionary objectForKey:@"Name"];
    newSite.timeZoneAbbreviation = [siteDictionary objectForKey:@"TimeZoneAbbreviation"];
    newSite.timeZoneOffset = [siteDictionary objectForKey:@"TimeZoneOffset"];

    newSite.type = [siteDictionary objectForKey:@"__type"];
    
    return newSite;
}

@end
