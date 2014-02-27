//
//  Image.h
//  Sensors
//
//  Created by John Jusayan on 2/26/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Site;

@interface Image : NSManagedObject

/** @abstract Identifier for object
 */
@property (nonatomic, retain) NSString * id;

/** @abstract Image byte data
 */
@property (nonatomic, retain) NSData * data;

/** @abstract Date this image was create
 */
@property (nonatomic, retain) NSDate * date;

/** @abstract File name for this image
 */
@property (nonatomic, retain) NSString * fileName;

/** @abstract Display name for this image
 */
@property (nonatomic, retain) NSString * name;

/** @abstract Sorting index
 */
@property (nonatomic, retain) NSNumber * orderIndex;

/** @abstract The url for this image on the FTP server
 */
@property (nonatomic, retain) NSString * url;

/** @abstract The site that this image belongs to
 */
@property (nonatomic, retain) Site *site;

/** @abstract Convenience creation method for creating an image
 @param JSON dictionary containing object data
 @param The managed object context where this managed object will be inserted
 @return Created Image
 */
+ (instancetype)imageFromDictionary:(NSDictionary*)imageDictionary inManagedObjectContext:(NSManagedObjectContext*)context;

@end
