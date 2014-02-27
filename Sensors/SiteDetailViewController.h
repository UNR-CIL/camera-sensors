//
//  SiteDetailViewController.h
//  Sensors
//
//  Created by John Jusayan on 12/30/13.
//  Copyright (c) 2013 Treeness, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Site;

@interface SiteDetailViewController : UICollectionViewController

/**
 Site being displayed
 */
@property (nonatomic, strong) Site *detailSite;

@end
