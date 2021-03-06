//
//  Site.h
//  GB SciCam
//
//  Created by John Jusayan on 1/17/16.
//  Copyright © 2016 Treeness, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image, Project;

NS_ASSUME_NONNULL_BEGIN

@interface Site : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (instancetype)siteFromDictionary:(NSDictionary*)siteDictionary inManagedObjectContext:(NSManagedObjectContext*)context;

@end

NS_ASSUME_NONNULL_END

#import "Site+CoreDataProperties.h"
