//
//  Stream.h
//  GB SciCam
//
//  Created by John Jusayan on 3/9/16.
//  Copyright © 2016 Treeness, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image, Site;

NS_ASSUME_NONNULL_BEGIN

@interface Stream : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (instancetype)streamFromDictionary:(NSDictionary*)streamDictionary inManagedObjectContext:(NSManagedObjectContext*)context;

@end

NS_ASSUME_NONNULL_END

#import "Stream+CoreDataProperties.h"
