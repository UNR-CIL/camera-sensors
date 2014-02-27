//
//  NSURL+SCUtilities.h
//  Sensors
//
//  Created by John Jusayan on 2/3/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSURL (SCUtilities)

/**---------------------------------------------------------------------------------------
* @name Retrieve all the available regions
*  ---------------------------------------------------------------------------------------
*/

/** Creates a url used for getting the full list of regions

@param string A parameter that is passed in.
 @return NSURL instance for retrieving all available regions
*/
+ (NSURL*)sc_fetchRegionsURL;

/**---------------------------------------------------------------------------------------
 * @name Retrieve the sites in a specific region
 *  ---------------------------------------------------------------------------------------
 */
/** Creates a url used for retrieving sites belong to a specific region
 
 @param regionName String identifier for the region
 @return NSURL instance used for retrieving the sites belonging to a specific region
 */
+ (NSURL*)sc_fetchSitesURLForRegionNamed:(NSString*)regionName;

/**
 Creates a url used for retrieving the latest items for a site in a region
 
 @param regionName String identifier for that region
 @param siteName String identifier for that site
 
 @return NSURL instance used for retrieving the data for a specific site in a specific region
 */
+ (NSURL*)sc_fetchLatestItemsURLForRegion:(NSString*)regionName site:(NSString*)siteName;

@end
