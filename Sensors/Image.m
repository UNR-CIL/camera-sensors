//
//  Image.m
//  Sensors
//
//  Created by John Jusayan on 2/5/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import "Image.h"
#import "Camera.h"
#import "NSManagedObject+SCEntityFetchOrInsert.h"

@implementation Image

@dynamic data;
@dynamic date;
@dynamic fileName;
@dynamic name;
@dynamic orderIndex;
@dynamic id;
@dynamic url;
@dynamic camera;

+ (instancetype)imageFromDictionary:(NSDictionary*)imageDictionary inManagedObjectContext:(NSManagedObjectContext*)context
{
    Image *newImage = [self sc_entityFetchOrInsertForKey:@"id" withValue:[imageDictionary objectForKey:@"url"] inManagedObjectContext:context];
    newImage.name = [imageDictionary objectForKey:@"name"];
    newImage.id = [imageDictionary objectForKey:@"url"];
    newImage.url = [imageDictionary objectForKey:@"url"];

#warning This needs to be NSdate
    //newImage.date = [imageDictionary objectForKey:@"date"];
    return newImage;
}

@end
