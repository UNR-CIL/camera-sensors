//
//  AppDelegate.h
//  Sensors
//
//  Created by John Jusayan on 11/27/13.
//  Copyright (c) 2013 CSE UNR All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

/**Main application window for the UI
 
 @discussion This is the root view for all UI elements
 */
@property (strong, nonatomic) UIWindow *window;

/**Core Data context
 
 @discussion This manages all the NSManagedObject instances
*/
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

/**Core Data model
 
 @discussion This provides the model schema that defines the Entities
*/
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

/**Core Data store coordinator

 @discussion This handles communicating with the context and persisting its contents to disk
*/
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/**Saves the context and persists the contents
 
@discussion This is called when the application goes into the background
*/
- (void)saveContext;

/**Location of the documents directory for the application
 
@discussion This is where the sqlite file is located
 */
- (NSURL *)applicationDocumentsDirectory;

@end
