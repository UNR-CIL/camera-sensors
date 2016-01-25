//
//  Project.h
//  GB SciCam
//
//  Created by John Jusayan on 1/17/16.
//  Copyright © 2016 Treeness, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Project : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (instancetype)projectFromDictionary:(NSDictionary*)projectDictionary inManagedObjectContext:(NSManagedObjectContext*)context;

@end

NS_ASSUME_NONNULL_END

#import "Project+CoreDataProperties.h"
