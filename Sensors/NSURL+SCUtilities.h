//
//  NSURL+SCUtilities.h
//  Sensors
//
//  Created by John Jusayan on 2/3/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (SCUtilities)

+ (NSURL*)sc_fetchRegionsURL;
+ (NSURL*)sc_fetchSitesURLForRegionNamed:(NSString*)regionName;
+ (NSURL*)sc_fetchLatestItemsURLForRegion:(NSString*)regionName site:(NSString*)siteName;

@end
