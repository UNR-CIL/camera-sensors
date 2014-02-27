//
//  CameraListViewController.h
//  Sensors
//
//  Created by John Jusayan on 12/2/13.
//  Copyright (c) 2013 CSE UNR All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraListViewController : UICollectionViewController

/** @abstract Core Data managed object context
 
 @discussion This is a reference to the main managed object context from the Application Delegate
 */
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
