//
//  NSURL+SCUtilities.m
//  Sensors
//
//  Created by John Jusayan on 2/3/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import "NSURL+SCUtilities.h"

@implementation NSURL (SCUtilities)

+ (NSURL*)sc_fetchRegionsURL
{
    NSString *urlString = [SCurlRoot stringByAppendingPathComponent:@"/nccp_images/regions"];
    return [NSURL URLWithString:urlString];
}

+ (NSURL*)sc_fetchSitesURLForRegionNamed:(NSString*)regionName
{
    NSString *urlString = [SCurlRoot stringByAppendingPathComponent:@"/nccp_images/%@/sites"];
    urlString = [NSString stringWithFormat:urlString, regionName];
    return [NSURL URLWithString:urlString];
}

+ (NSURL*)sc_fetchLatestItemsURLForRegion:(NSString*)regionName site:(NSString*)siteName
{
    NSString *urlString = [SCurlRoot stringByAppendingPathComponent:@"/nccp_images/%@/%@/latest"];
    urlString = [NSString stringWithFormat:urlString, regionName, siteName];
    return [NSURL URLWithString:urlString];
}

@end
