//
//  Stream+CoreDataProperties.h
//  GB SciCam
//
//  Created by John Jusayan on 3/9/16.
//  Copyright © 2016 Treeness, LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Stream.h"

NS_ASSUME_NONNULL_BEGIN

@interface Stream (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) Site *site;
@property (nullable, nonatomic, retain) NSSet<Image *> *images;

@end

@interface Stream (CoreDataGeneratedAccessors)

- (void)addImagesObject:(Image *)value;
- (void)removeImagesObject:(Image *)value;
- (void)addImages:(NSSet<Image *> *)values;
- (void)removeImages:(NSSet<Image *> *)values;

@end

NS_ASSUME_NONNULL_END
