//
//  Site.h
//  Sensors
//
//  Created by John Jusayan on 2/26/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image, Region;

@interface Site : NSManagedObject

/** @abstract Identifier for object
 */
@property (nonatomic, retain) NSString * id;

/** @abstract Latitude for the site
 */
@property (nonatomic, retain) NSNumber * latitude;

/** @abstract Longitude for site
 */
@property (nonatomic, retain) NSNumber * longitude;

/** @abstract The name of the site
 */
@property (nonatomic, retain) NSString * name;

/** @abstract The name of the region that that site is in
 */
@property (nonatomic, retain) NSString * regionName;

/** @abstract Thumbnail photo for the site
 */
@property (nonatomic, retain) id thumbnailImage;

/** @abstract Images belonging to the site
 */
@property (nonatomic, retain) NSSet *images;

/** @abstract The region that the site is located
 */
@property (nonatomic, retain) Region *region;

/** @abstract Convenience creation method for creating a site
 @param JSON dictionary containing object data
 @param The managed object context where this managed object will be inserted
 @return Created Site
 */
+ (instancetype)siteFromDictionary:(NSDictionary*)siteDictionary inManagedObjectContext:(NSManagedObjectContext*)context;

@end

@interface Site (CoreDataGeneratedAccessors)

/** @abstract Add an image to this site
 */
- (void)addImagesObject:(Image *)value;

/** @abstract Remove an image from this site
 */
- (void)removeImagesObject:(Image *)value;

/** @abstract Add a set of images to this site
 */
- (void)addImages:(NSSet *)values;

/** @abstract Remove a set of images from this this
 */
- (void)removeImages:(NSSet *)values;

@end
