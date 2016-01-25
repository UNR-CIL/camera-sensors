//
//  NSURL+SCUtilities.h
//  Sensors
//
//  Created by John Jusayan on 2/3/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Project;

@interface NSURL (SCUtilities)

/**
 Creates a url used to retrieve a listing of projects
 
 @return NSURL instance for retrieving project listing
 */
+ (NSURL*)sc_projectListURL;


/**
 Creates a url used to retrieve a listing of sites for a project
 
 @param Project instance for the requested sites
 @return NSURL instance for retrieving project listing
 */
+ (NSURL*)sc_sitesURLForProject:(Project*)project;


@end
