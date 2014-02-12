//
//  NSManagedObject+EntityFetchOrInsert.h
//  Sensors
//
//  Created by John Jusayan on 2/5/14.
//  Copyright (c) 2013 CSE UNR All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (SCEntityFetchOrInsert)

+ (id)sc_entityFetchOrInsertForKey:(NSString*)propertyName withValue:(NSString*)propertyValue inManagedObjectContext:(NSManagedObjectContext*)context;

@end
