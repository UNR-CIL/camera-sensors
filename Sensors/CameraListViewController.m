//
//  CameraListViewController.m
//  Sensors
//
//  Created by John Jusayan on 12/2/13.
//  Copyright (c) 2013 CSE UNR All rights reserved.
//

#import "CameraListViewController.h"
#import "CameraPreviewCell.h"
#import <QuartzCore/QuartzCore.h>

#import "Camera.h"
#import "Image.h"
#import "AppDelegate.h"
#import "NSString+SCURLParsing.h"
#import "CameraDetailViewController.h"
#import "CollectionHeaderView.h"

#import "AFNetworking.h"
#import "NSURL+SCUtilities.h"

@interface CameraListViewController ()

@property (strong, nonatomic) NSArray *cameraItems;
@property (strong, nonatomic) AFHTTPRequestOperationManager *httpRequestOperationManager;

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
    
    [self.httpRequestOperationManager GET:[[NSURL sc_fetchRegionsURL] absoluteString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *regions = (NSArray*)responseObject;
        
        [regions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *regionName = (NSString*)obj;
            regionName = [regionName lowercaseString];
            
            [self.httpRequestOperationManager GET:[[NSURL sc_fetchSitesURLForRegionNamed:regionName] absoluteString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSArray *siteNames = (NSArray*)responseObject;
                
                [siteNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    [self.httpRequestOperationManager GET:[[NSURL sc_fetchLatestItemsURLForRegion:regionName site:obj] absoluteString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        
                        NSLog(@">>> %@", responseObject);
                        
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        
                        NSLog(@">>> ## %@\n%@", operation, error.userInfo);
                        
                    }];
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@">>> ## %@\n%@", operation, error.userInfo);
            }];
            
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@">>> ## %@\n%@", operation, error.userInfo);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.cameraItems[section] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.cameraItems count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CameraPreviewCell" forIndexPath:indexPath];
    Camera *camera = [self.cameraItems[indexPath.section] objectAtIndex:indexPath.row];
    [[(CameraPreviewCell*)cell imageView] setImage:camera.thumbnailImage];

    return cell;
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        CollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeaderView" forIndexPath:indexPath];
        Camera *camera = [self.cameraItems[indexPath.section] objectAtIndex:indexPath.row];

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
        Camera *selectedCamera = [[self.cameraItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        [segue.destinationViewController setDetailCamera:selectedCamera];
    }
}

@end
