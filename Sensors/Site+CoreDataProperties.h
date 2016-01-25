//
//  Site+CoreDataProperties.h
//  GB SciCam
//
//  Created by John Jusayan on 1/17/16.
//  Copyright © 2016 Treeness, LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Site.h"

NS_ASSUME_NONNULL_BEGIN

@interface Site (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *alias;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) id thumbnailImage;
@property (nullable, nonatomic, retain) NSDate *thumbnailImageDate;
@property (nullable, nonatomic, retain) NSNumber *altitude;
@property (nullable, nonatomic, retain) NSString *timeZoneAbbreviation;
@property (nullable, nonatomic, retain) NSString *timeZoneOffset;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSSet<Image *> *images;
@property (nullable, nonatomic, retain) NSString *projectName;
@property (nullable, nonatomic, retain) Project *project;

@end

@interface Site (CoreDataGeneratedAccessors)

- (void)addImagesObject:(Image *)value;
- (void)removeImagesObject:(Image *)value;
- (void)addImages:(NSSet<Image *> *)values;
- (void)removeImages:(NSSet<Image *> *)values;

@end

NS_ASSUME_NONNULL_END
