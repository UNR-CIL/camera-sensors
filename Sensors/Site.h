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

/**Identifier for object
 */
@property (nonatomic, retain) NSString * id;

/**Actual site identifier for object
 */
@property (nonatomic, retain) NSString * alias;

/**Latitude for the site
 */
@property (nonatomic, retain) NSNumber * latitude;

/**Longitude for site
 */
@property (nonatomic, retain) NSNumber * longitude;

/**The name of the site
 */
@property (nonatomic, retain) NSString * name;

/**The name of the region that that site is in
 */
@property (nonatomic, retain) NSString * regionName;

/**Thumbnail photo for the site
 */
@property (nonatomic, retain) id thumbnailImage;

/**Images belonging to the site
 */
@property (nonatomic, retain) NSSet *images;

/**The region that the site is located
 */
@property (nonatomic, retain) Region *region;

/**Convenience creation method for creating a site
 @param JSON dictionary containing object data
 @param The managed object context where this managed object will be inserted
 @return Created Site
 */
+ (instancetype)siteFromDictionary:(NSDictionary*)siteDictionary inManagedObjectContext:(NSManagedObjectContext*)context;

@end

@interface Site (CoreDataGeneratedAccessors)

/**Add an image to this site
 */
- (void)addImagesObject:(Image *)value;

/**Remove an image from this site
 */
- (void)removeImagesObject:(Image *)value;

/**Add a set of images to this site
 */
- (void)addImages:(NSSet *)values;

/**Remove a set of images from this this
 */
- (void)removeImages:(NSSet *)values;

@end
