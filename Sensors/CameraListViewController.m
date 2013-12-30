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

@interface CameraListViewController ()

@property (nonatomic, strong) NSArray *cameraItems;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    self.title = @"Cameras";
    
    self.cameraItems = @[[NSMutableArray new], [NSMutableArray new]];
    
    NSArray *sheepURLs = @[
                           @"ftp://sensor.nevada.edu/Raw%20Data%20Files/Nevada%20Climate%20Change%20Project/Sheep/Site%201/Camera/Images/",
                           @"ftp://sensor.nevada.edu/Raw%20Data%20Files/Nevada%20Climate%20Change%20Project/Sheep/Site%202/Camera/Images/",
                           @"ftp://sensor.nevada.edu/Raw%20Data%20Files/Nevada%20Climate%20Change%20Project/Sheep/Site%203/Camera/Images/",
                           @"ftp://sensor.nevada.edu/Raw%20Data%20Files/Nevada%20Climate%20Change%20Project/Sheep/Site%204/Camera/Images/",
                           ];
    
    NSArray *snakeURLs = @[
                           @"ftp://sensor.nevada.edu/Raw%20Data%20Files/Nevada%20Climate%20Change%20Project/Snake/Site%201/Camera/Images/",
                           @"ftp://sensor.nevada.edu/Raw%20Data%20Files/Nevada%20Climate%20Change%20Project/Snake/Site%202/Camera/Images/",
                           @"ftp://sensor.nevada.edu/Raw%20Data%20Files/Nevada%20Climate%20Change%20Project/Snake/Site%203/Camera/Images/"];
    
    [snakeURLs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Camera *newCamera = [NSEntityDescription insertNewObjectForEntityForName:@"Camera" inManagedObjectContext:self.managedObjectContext];
        newCamera.baseURL = obj;
        newCamera.groupName = @"Snake";
        [self.cameraItems[0] addObject:newCamera];
    }];
    
    [sheepURLs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Camera *newCamera = [NSEntityDescription insertNewObjectForEntityForName:@"Camera" inManagedObjectContext:self.managedObjectContext];
        newCamera.baseURL = obj;
        newCamera.groupName = @"Sheep";
        [self.cameraItems[1] addObject:newCamera];
    }];
    
    [self.cameraItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableArray *siteCameras = (NSMutableArray*)obj;
        
        [siteCameras enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            Camera *camera = (Camera*)obj;
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[camera.baseURL stringByAppendingPathComponent:@"p01.jpg"]]];
            
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                if (data) {
                    UIImage *image = [[UIImage alloc] initWithData:data];
                    
                    if (image) {
                        camera.thumbnailImage = image;
                        [self.collectionView reloadData];
                    }
                }
                
                if (connectionError) {
                    NSLog(@"%@", connectionError.userInfo);
                }
            }];
        }];
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected");
}

@end
