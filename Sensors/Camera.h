//
//  Camera.h
//  Sensors
//
//  Created by John Jusayan on 12/16/13.
//  Copyright (c) 2013 CSE UNR All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image;

@interface Camera : NSManagedObject

@property (nonatomic, retain) NSString * groupName;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * orderIndex;
@property (nonatomic, retain) id thumbnailImage;
@property (nonatomic, retain) NSString * baseURL;
@property (nonatomic, retain) NSSet *images;

- (NSArray*)photoURLsFordataString:(NSString*)dataString;

@end

@interface Camera (CoreDataGeneratedAccessors)

- (void)addImagesObject:(Image *)value;
- (void)removeImagesObject:(Image *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

@end
