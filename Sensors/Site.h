//
//  Site.h
//  Sensors
//
//  Created by John Jusayan on 2/5/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Camera, Region;

@interface Site : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * regionName;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) id thumbnailImage;
@property (nonatomic, retain) NSSet *cameras;
@property (nonatomic, retain) Region *region;

+ (instancetype)siteFromDictionary:(NSDictionary*)siteDictionary inManagedObjectContext:(NSManagedObjectContext*)context;

@end

@interface Site (CoreDataGeneratedAccessors)

- (void)addCamerasObject:(Camera *)value;
- (void)removeCamerasObject:(Camera *)value;
- (void)addCameras:(NSSet *)values;
- (void)removeCameras:(NSSet *)values;

@end
