//
//  NSURL+SCUtilities.m
//  Sensors
//
//  Created by John Jusayan on 2/3/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import "NSURL+SCUtilities.h"

/* This category adds convenience methods to make it easier to create REST urls
 **/
@implementation NSURL (SCUtilities)

/**
 Creates a url used for getting the full list of regions
 
 @return NSURL instance for retrieving all available regions
 */
+ (NSURL*)sc_fetchRegionsURL
{
    NSString *urlString = [SCurlRoot stringByAppendingPathComponent:@"/nccp_images/regions"];
    return [NSURL URLWithString:urlString];
}

/**
 Creates a url used for retrieving sites belong to a specific region
 
 @param regionName String identifier for the region
 
 @return NSURL instance used for retrieving the sites belonging to a specific region
 */
+ (NSURL*)sc_fetchSitesURLForRegionNamed:(NSString*)regionName
{
    NSString *urlString = [SCurlRoot stringByAppendingPathComponent:@"/nccp_images/%@/sites"];
    urlString = [NSString stringWithFormat:urlString, regionName];
    return [NSURL URLWithString:urlString];
}

/**
 Creates a url used for retrieving the latest items for a site in a region
 
 @param regionName String identifier for that region
 @param siteName String identifier for that site
 
 @return NSURL instance used for retrieving the data for a specific site in a specific region
 */
+ (NSURL*)sc_fetchLatestItemsURLForRegion:(NSString*)regionName site:(NSString*)siteName
{
    NSString *urlString = [SCurlRoot stringByAppendingPathComponent:@"/nccp_images/%@/%@/latest"];
    urlString = [NSString stringWithFormat:urlString, regionName, siteName];
    return [NSURL URLWithString:urlString];
}

@end
