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

/**  Site being displayed
*/
@property (nonatomic, strong) Site *detailSite;

/** Managed Object Context
 */
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
