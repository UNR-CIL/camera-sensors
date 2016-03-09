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
#import "Stream.h"
#import "Project.h"

#import "PhotoViewController.h"

#import "ImagePreviewCell.h"

@interface SiteDetailViewController ()

@property (strong, nonatomic) NSArray *imageURLs;
@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) UIPopoverController *photoPopover;

@property (nonatomic) NSString* currentExportId;

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
    
  
    self.title = self.detailSite.name;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

    
    NSLog(@">>> This is the detail Site %@", self.detailSite);
    NSString *streamImagesFormatString = @"images/export/latest/stream/%@/addTimeStamps/True";
    
    NSURL *streamsURL = [NSURL sc_streamsURLForSite:self.detailSite];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:streamsURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data != nil) {
            NSError *jsonError;
            NSDictionary *jsonDictionary = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            NSArray *streams = (NSArray*)jsonDictionary[@"Data"];
            for (NSDictionary *streamDictionary in streams) {
                Stream *newStream = [Stream streamFromDictionary:streamDictionary inManagedObjectContext:self.managedObjectContext];
                newStream.site = self.detailSite;
                NSLog(@">>>> This Stream: %@", newStream);
            }
            
            for (Stream *stream in self.detailSite.streams.allObjects) {
                
                NSURL *url = [NSURL URLWithString:[self.detailSite.project.imageRetrievalUrl stringByAppendingPathComponent:[NSString stringWithFormat:streamImagesFormatString, stream.id]]];
                NSLog(@">>> url %@", url);
                NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    NSLog(@">>> resonse %@", response);
                    NSLog(@">>>> error %@", error);
                    if (data != nil) {
                        NSError *jsonError;
                        NSDictionary *jsonDictionary = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                        NSString *exportId = (NSString*)jsonDictionary[@"Data"];
                        self.currentExportId = exportId;
                        NSLog(@">>>> stream JSON currentExportId %@", self.currentExportId);
                    }
                    
                }];
                [dataTask resume];
            }
        }
    }];
    
    [task resume];
    
    
}

- (void)checkStatusOfExport:(NSString*)exportId
{
    
}

- (NSURL*)exportStatusURLForExportId:(NSString*)exportId
{
    NSString *exportStatusString = @"/images/export/%@/status"; // export id string

    NSURL *url = [NSURL URLWithString:[self.detailSite.project.imageRetrievalUrl stringByAppendingPathComponent:[NSString stringWithFormat:exportStatusString, exportId]]];
    return url;
}

- (NSURL*)exportLocationURLForExportId:(NSString*)exportId
{
    NSString *exportLocation = @"/images/export/%@/location"; // export location
    NSURL *url = [NSURL URLWithString:[self.detailSite.project.imageRetrievalUrl stringByAppendingPathComponent:[NSString stringWithFormat:exportLocation, exportId]]];
    return url;
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
            [self.photoPopover presentPopoverFromRect:cell.bounds inView:cell permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        
        else {
            [self presentViewController:navigationController animated:YES completion:NULL];
        }
    }
}


@end
