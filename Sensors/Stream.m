//
//  Stream.m
//  GB SciCam
//
//  Created by John Jusayan on 3/9/16.
//  Copyright © 2016 Treeness, LLC. All rights reserved.
//

#import "Stream.h"
#import "Image.h"
#import "Site.h"
#import "NSManagedObject+SCEntityFetchOrInsert.h"

@implementation Stream

// Insert code here to add functionality to your managed object subclass
+ (instancetype)streamFromDictionary:(NSDictionary*)streamDictionary inManagedObjectContext:(NSManagedObjectContext*)context
{
    Stream *newStream = [self sc_entityFetchOrInsertForKey:@"id" withValue:[streamDictionary objectForKey:@"ID"] inManagedObjectContext:context];
    
    newStream.id = [streamDictionary objectForKey:@"ID"];
    newStream.name = [streamDictionary objectForKey:@"Name"];
    newStream.type = [streamDictionary objectForKey:@"__type"];
    return newStream;
}

@end
