//
//  Camera.h
//  Sensors
//
//  Created by John Jusayan on 2/5/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image, Site;

@interface Camera : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * orderIndex;
@property (nonatomic, retain) id thumbnailImage;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSSet *images;
@property (nonatomic, retain) Site *site;

+ (instancetype)cameraFromDictionary:(NSDictionary*)cameraDictionary inManagedObjectContext:(NSManagedObjectContext*)context;

@end

@interface Camera (CoreDataGeneratedAccessors)

- (void)addImagesObject:(Image *)value;
- (void)removeImagesObject:(Image *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

@end
