//
//  NSManagedObject+EntityFetchOrInsert.m
//  Sensors
//
//  Created by John Jusayan on 2/5/14.
//  Copyright (c) 2014 CSE UNR All rights reserved.
//

#import "NSManagedObject+SCEntityFetchOrInsert.h"

@implementation NSManagedObject (SCEntityFetchOrInsert)

+ (id)sc_entityFetchOrInsertForKey:(NSString*)propertyName withValue:(NSString*)propertyValue inManagedObjectContext:(NSManagedObjectContext*)context
{
    NSString *entityName = NSStringFromClass([self class]);
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@",  propertyName, propertyValue];
    fetchRequest.predicate = predicate;
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    
    NSManagedObject *newObject;
    
    if (results.count > 0) {
        NSLog(@"return existing object: %@", propertyValue);
        newObject = [results firstObject];
    }
    else {
        NSLog(@"return new object: %@", propertyValue);
        newObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
    }
    
    return newObject;
}

@end
