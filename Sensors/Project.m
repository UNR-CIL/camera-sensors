//
//  Project.m
//  GB SciCam
//
//  Created by John Jusayan on 1/17/16.
//  Copyright © 2016 Treeness, LLC. All rights reserved.
//

#import "Project.h"
#import "NSManagedObject+SCEntityFetchOrInsert.h"

@implementation Project

// Insert code here to add functionality to your managed object subclass

+ (instancetype)projectFromDictionary:(NSDictionary*)projectDictionary inManagedObjectContext:(NSManagedObjectContext*)context
{
    Project *newProject = [self sc_entityFetchOrInsertForKey:@"name" withValue:[projectDictionary objectForKey:@"Name"] inManagedObjectContext:context];
    
    newProject.type = [projectDictionary objectForKey:@"__type"];
    newProject.name = [projectDictionary objectForKey:@"Name"];
    newProject.imageRetrievalUrl = [projectDictionary objectForKey:@"ImageRetrievalUrl"];
    newProject.infrastructureUrl = [projectDictionary objectForKey:@"InfrastructureUrl"];
    return newProject;
}


@end
