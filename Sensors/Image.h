//
//  Image.h
//  Sensors
//
//  Created by John Jusayan on 2/5/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Camera;

@interface Image : NSManagedObject

@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * orderIndex;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) Camera *camera;

+ (instancetype)imageFromDictionary:(NSDictionary*)imageDictionary inManagedObjectContext:(NSManagedObjectContext*)context;

@end
