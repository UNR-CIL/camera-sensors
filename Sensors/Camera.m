//
//  Camera.m
//  Sensors
//
//  Created by John Jusayan on 2/5/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import "Camera.h"
#import "Image.h"
#import "Site.h"
#import "NSManagedObject+SCEntityFetchOrInsert.h"

@implementation Camera

@dynamic name;
@dynamic orderIndex;
@dynamic thumbnailImage;
@dynamic id;
@dynamic images;
@dynamic site;

+ (instancetype)cameraFromDictionary:(NSDictionary*)cameraDictionary inManagedObjectContext:(NSManagedObjectContext*)context
{
    Camera *newCamera = [self sc_entityFetchOrInsertForKey:@"id" withValue:[cameraDictionary objectForKey:@"id"] inManagedObjectContext:context];
    newCamera.name = [cameraDictionary objectForKey:@"name"];
    newCamera.id = [cameraDictionary objectForKey:@"id"];
    return newCamera;
}

@end
