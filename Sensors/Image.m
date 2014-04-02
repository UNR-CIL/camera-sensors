//
//  Image.m
//  Sensors
//
//  Created by John Jusayan on 2/26/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import "Image.h"
#import "Site.h"

#import "NSManagedObject+SCEntityFetchOrInsert.h"

@implementation Image

@dynamic data;
@dynamic date;
@dynamic fileName;
@dynamic id;
@dynamic name;
@dynamic orderIndex;
@dynamic url;
@dynamic site;

+ (instancetype)imageFromDictionary:(NSDictionary*)imageDictionary inManagedObjectContext:(NSManagedObjectContext*)context
{
    Image *newImage = [self sc_entityFetchOrInsertForKey:@"id" withValue:[imageDictionary objectForKey:@"url"] inManagedObjectContext:context];
    newImage.name = [imageDictionary objectForKey:@"name"];
    newImage.id = [imageDictionary objectForKey:@"url"];
    newImage.url = [imageDictionary objectForKey:@"url"];
    
    NSNumber *dateNumber = [imageDictionary objectForKey:@"date"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateNumber.doubleValue/1000];
    
    newImage.date = date;
    return newImage;
}

@end
