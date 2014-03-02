//
//  Region.h
//  Sensors
//
//  Created by John Jusayan on 2/26/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Site;

@interface Region : NSManagedObject

/**Identifier for object
 */
@property (nonatomic, retain) NSString * id;

/**Latitude for the region
 */
@property (nonatomic, retain) NSNumber * latitude;

/**Longitude for region
 */
@property (nonatomic, retain) NSNumber * longitude;

/**The name of the region
 */
@property (nonatomic, retain) NSString * name;

/**Thumbnail photo for the region
 */
@property (nonatomic, retain) id thumbnailImage;

/**Sites in the region
 */
@property (nonatomic, retain) NSSet *sites;

/**Convenience creation method for creating a site
 @param JSON dictionary containing object data
 @param The managed object context where this managed object will be inserted
 @return Created Region
 */
+ (instancetype)regionFromName:(NSString*)regionName inManagedObjectContext:(NSManagedObjectContext*)context;

@end

@interface Region (CoreDataGeneratedAccessors)

/**Add a site to this region
 */
- (void)addSitesObject:(Site *)value;

/**Remove a site from this region
 */
- (void)removeSitesObject:(Site *)value;

/**Add a set of sites to this region
 */
- (void)addSites:(NSSet *)values;

/**Remove a set of sites from this region
 */
- (void)removeSites:(NSSet *)values;

@end
