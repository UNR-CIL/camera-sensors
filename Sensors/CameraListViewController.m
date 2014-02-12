//
//  CameraListViewController.m
//  Sensors
//
//  Created by John Jusayan on 12/2/13.
//  Copyright (c) 2013 CSE UNR All rights reserved.
//

#import "CameraListViewController.h"
#import "SitePreviewCell.h"
#import <QuartzCore/QuartzCore.h>

#import "Region.h"
#import "Site.h"
#import "Camera.h"
#import "Image.h"
#import "NSManagedObject+SCEntityFetchOrInsert.h"

#import "AppDelegate.h"
#import "NSString+SCURLParsing.h"
#import "SiteDetailViewController.h"
#import "CollectionHeaderView.h"

#import "AFNetworking.h"
#import "NSURL+SCUtilities.h"

@interface CameraListViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSMutableArray *regions;
@property (strong, nonatomic) AFHTTPRequestOperationManager *httpRequestOperationManager;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation CameraListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSArray*)regions
{
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    self.title = @"Cameras";
    
    
    self.httpRequestOperationManager = [AFHTTPRequestOperationManager manager];
    self.httpRequestOperationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [self.httpRequestOperationManager GET:[[NSURL sc_fetchRegionsURL] absoluteString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *regionNames = (NSArray*)responseObject;

        [regionNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *regionName = (NSString*)obj;
            Region *region = [Region regionFromName:regionName inManagedObjectContext:self.managedObjectContext];
            
            [self.httpRequestOperationManager GET:[[NSURL sc_fetchSitesURLForRegionNamed:region.id] absoluteString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSArray *siteNames = (NSArray*)responseObject;

                [siteNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    Site *site = [Site siteFromDictionary:@{@"id":[region.id stringByAppendingString:obj], @"name":obj} inManagedObjectContext:self.managedObjectContext];
                    site.regionName = regionName;
                    
                    NSDictionary *cameraDictionary = @{@"name": site.id, @"id": site.id};
                    Camera *camera = [Camera cameraFromDictionary:cameraDictionary inManagedObjectContext:self.managedObjectContext];
                    [site addCamerasObject:camera];
                    
                    
                    [self.httpRequestOperationManager GET:[[NSURL sc_fetchLatestItemsURLForRegion:[regionName lowercaseString] site:obj] absoluteString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        Image *newImage = [Image imageFromDictionary:responseObject inManagedObjectContext:self.managedObjectContext];
                        
                        
                        NSURL *url = [NSURL URLWithString:[newImage.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                        NSURLRequest *imageRequest = [NSURLRequest requestWithURL:url];
                        
                        [NSURLConnection sendAsynchronousRequest:imageRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                            if (data) {
                                UIImage *image = [[UIImage alloc] initWithData:data];
                                if (image) {
                                    
                                    camera.thumbnailImage = image;
                                    site.thumbnailImage = image;
                                }
                            }
                        }];

                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        
                        NSLog(@"%@\n%@", operation, error.userInfo);
                    }];
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@\n%@", operation, error.userInfo);
            }];
            
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@\n%@", operation, error.userInfo);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [[self.fetchedResultsController sections] count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"SitePreviewCell" forIndexPath:indexPath];
    [self configureCollectionView:collectionView cell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCollectionView:(UICollectionView*)collectionView cell:(UICollectionViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    Site *site = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [[(SitePreviewCell*)cell imageView] setImage:site.thumbnailImage];
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        CollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeaderView" forIndexPath:indexPath];
        
        if (self.fetchedResultsController.fetchedObjects.count) {
            Site *site = [self.fetchedResultsController objectAtIndexPath:indexPath];
            headerView.titleLabel.text = site.regionName;
        }
        
        reusableview = headerView;
    }
    return reusableview;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"CameraDetailViewController" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CameraDetailViewController"]) {
        NSIndexPath *indexPath = (NSIndexPath*)sender;
        Camera *selectedCamera = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [segue.destinationViewController setDetailCamera:selectedCamera];
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Site" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"regionName" cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
//    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
//            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
//            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
//    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
//            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate: {
            //            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
//            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
//            [self configureCollectionView:self.collectionView cell:cell atIndexPath:indexPath];
            break;
        }
        case NSFetchedResultsChangeMove:
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
//    [self.tableView endUpdates];
    [self.collectionView reloadData];
}


@end
