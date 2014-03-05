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
#import "Image.h"

#import "ImagePreviewCell.h"

@interface SiteDetailViewController ()

@property (strong, nonatomic) NSArray *imageURLs;
@property (strong, nonatomic) NSMutableArray *images;

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
    
    self.images = [NSMutableArray new];
    
    [appDelegate.sharedRequestOperationManager GET:[[NSURL sc_fetchImagesURLForRegion:[self.detailSite.regionName lowercaseString] site:self.detailSite.name limit:50] absoluteString] parameters:NULL success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *sites = (NSArray*)responseObject;
        
        [sites enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *imageDictionary = (NSDictionary*)obj;
            Image *newImage = [Image imageFromDictionary:imageDictionary inManagedObjectContext:self.managedObjectContext];
            
            newImage.site = self.detailSite;
            [self.images addObject:newImage];
            
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
        }];

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@">> Response %@", [error userInfo]);

    }];

    /*
    [appDelegate.sharedRequestOperationManager GET:[[NSURL sc_fetchLatestItemURLForRegion:[self.detailSite.regionName lowercaseString] site:self.detailSite.name] absoluteString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Image *newImage = [Image imageFromDictionary:responseObject inManagedObjectContext:self.managedObjectContext];
        
        
        NSURL *url = [NSURL URLWithString:[newImage.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *imageRequest = [NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:imageRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data) {
                UIImage *image = [[UIImage alloc] initWithData:data];
                if (image) {
                    site.thumbnailImage = image;
                }
            }
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@\n%@", operation, error.userInfo);
    }];

*/
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

    NSData *data = [[self.images objectAtIndex:indexPath.row] data];
    [[(ImagePreviewCell*)cell imageView] setImage:[UIImage imageWithData:data]];
    
    return cell;
}


@end
