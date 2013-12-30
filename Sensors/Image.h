//
//  Image.h
//  Sensors
//
//  Created by John Jusayan on 12/16/13.
//  Copyright (c) 2013 CSE UNR All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Camera;

@interface Image : NSManagedObject

@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * orderIndex;
@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) Camera *camera;

@end
