//
//  Camera.h
//  Sensors
//
//  Created by John Jusayan on 1/29/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image;

@interface Camera : NSManagedObject

@property (nonatomic, retain) NSString * baseURL;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * orderIndex;
@property (nonatomic, retain) id thumbnailImage;
@property (nonatomic, retain) NSSet *images;
@property (nonatomic, retain) NSManagedObject *site;
@end

@interface Camera (CoreDataGeneratedAccessors)

- (void)addImagesObject:(Image *)value;
- (void)removeImagesObject:(Image *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

@end
