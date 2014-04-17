//
//  SiteDetailViewController.m
//  Sensors
//
//  Created by John Jusayan on 12/30/13.
//  Copyright (c) 2013 Treeness, LLC. All rights reserved.
//

#import "SiteDetailViewController.h"
#import "NSURL+SCUtilities.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "Site.h"
#import "Region.h"
#import "Image.h"

#import "PhotoViewController.h"

#import "ImagePreviewCell.h"

@interface SiteDetailViewController ()

@property (strong, nonatomic) NSArray *imageURLs;
@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) UIPopoverController *photoPopover;

@end

@implementation SiteDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    self.images = [[[self.detailSite images] allObjects] mutableCopy];
  
    self.title = self.detailSite.name;
}

- (void)viewDidAppear:(BOOL)animated
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;

    [appDelegate.sharedRequestOperationManager GET:[[NSURL sc_fetchImagesURLForRegion:[self.detailSite.region.id lowercaseString] site:self.detailSite.alias limit:50] absoluteString] parameters:NULL success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *sites = (NSArray*)responseObject;
        
        [sites enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *imageDictionary = (NSDictionary*)obj;
                        
            Image *newImage = [Image imageFromDictionary:imageDictionary inManagedObjectContext:self.managedObjectContext];
            
            newImage.site = self.detailSite;
            [self.images addObject:newImage];
            
            if (newImage.data == nil) {
                NSURL *url = [NSURL URLWithString:[newImage.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                NSURLRequest *imageRequest = [NSURLRequest requestWithURL:url];
                
                [NSURLConnection sendAsynchronousRequest:imageRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                    if (data) {
                        UIImage *image = [[UIImage alloc] initWithData:data];
                        if (image) {
                            newImage.data = data;
                            [self.collectionView reloadData];
                        }
                    }
                }];
            }
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@">>> Response %@", [error userInfo]);
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.images count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ImagePreviewCell" forIndexPath:indexPath];

    Image *image = [self.images objectAtIndex:indexPath.row];
    
    ImagePreviewCell *imagePreviewCell = (ImagePreviewCell*)cell;
    imagePreviewCell.imageView.image = [UIImage imageWithData:image.data];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:gmt];
    
    imagePreviewCell.dateLabel.text = [dateFormatter stringFromDate:image.date];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    Image *detailImage = [self.images objectAtIndex:indexPath.row];
    [self showPhotoDetail:detailImage forCell:cell];
}

- (void)showPhotoDetail:(Image*)detailImage forCell:(UICollectionViewCell*)cell
{
    if (detailImage.data) {
        PhotoViewController *viewController = [PhotoViewController photoViewController];
        viewController.image =  [UIImage imageWithData:detailImage.data];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.photoPopover = [[UIPopoverController alloc] initWithContentViewController:navigationController];
            [self.photoPopover presentPopoverFromRect:cell.frame inView:cell permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        
        else {
            [self presentViewController:navigationController animated:YES completion:NULL];
        }
    }
}


@end
