//
//  Site.h
//  Sensors
//
//  Created by John Jusayan on 1/29/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Camera, Region;

@interface Site : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) Region *region;
@property (nonatomic, retain) NSSet *cameras;
@end

@interface Site (CoreDataGeneratedAccessors)

- (void)addCamerasObject:(Camera *)value;
- (void)removeCamerasObject:(Camera *)value;
- (void)addCameras:(NSSet *)values;
- (void)removeCameras:(NSSet *)values;

@end
