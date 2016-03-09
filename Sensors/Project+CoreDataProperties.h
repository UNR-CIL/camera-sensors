//
//  Project+CoreDataProperties.h
//  GB SciCam
//
//  Created by John Jusayan on 3/9/16.
//  Copyright © 2016 Treeness, LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Project.h"
@class Site;

NS_ASSUME_NONNULL_BEGIN

@interface Project (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imageRetrievalUrl;
@property (nullable, nonatomic, retain) NSString *infrastructureUrl;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSSet<Site *> *sites;

@end

@interface Project (CoreDataGeneratedAccessors)

- (void)addSitesObject:(Site *)value;
- (void)removeSitesObject:(Site *)value;
- (void)addSites:(NSSet<Site *> *)values;
- (void)removeSites:(NSSet<Site *> *)values;

@end

NS_ASSUME_NONNULL_END
