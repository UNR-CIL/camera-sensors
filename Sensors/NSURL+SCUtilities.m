//
//  NSURL+SCUtilities.m
//  Sensors
//
//  Created by John Jusayan on 2/3/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import "NSURL+SCUtilities.h"
#import "Project.h"
#import "Site.h"

/* This category adds convenience methods to make it easier to create REST urls
 **/
@implementation NSURL (SCUtilities)

+ (NSURL*)sc_projectListURL
{
    NSString *urlString = @"http://sensor.nevada.edu/Services/Discovery/Webcam Projects/NRDC.Projects.Discovery.svc/discovery/projects";
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]];
    return url;
}

+ (NSURL*)sc_sitesURLForProject:(Project*)project
{
    NSString *urlString = [project.infrastructureUrl stringByAppendingPathComponent:@"/infrastructure/sites"];
    NSURL *url = [NSURL URLWithString:urlString];
    return url;
}

+ (NSURL*)sc_streamsURLForSite:(Site*)site
{
    NSString *urlString = [site.project.imageRetrievalUrl stringByAppendingPathComponent:[NSString stringWithFormat:@"/images/site/%@/streams", site.id]];
    NSURL *url = [NSURL URLWithString:urlString];
    return url;
}


@end
