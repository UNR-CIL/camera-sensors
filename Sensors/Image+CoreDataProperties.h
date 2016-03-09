//
//  Image+CoreDataProperties.h
//  GB SciCam
//
//  Created by John Jusayan on 3/9/16.
//  Copyright © 2016 Treeness, LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Image.h"

NS_ASSUME_NONNULL_BEGIN

@interface Image (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *data;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *fileName;
@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *orderIndex;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSManagedObject *stream;

@end

NS_ASSUME_NONNULL_END
