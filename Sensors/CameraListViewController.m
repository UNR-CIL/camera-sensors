//
//  CameraListViewController.m
//  Sensors
//
//  Created by John Jusayan on 12/2/13.
//  Copyright (c) 2013 Treeness, LLC. All rights reserved.
//

#import "CameraListViewController.h"
#import "CameraPreviewCell.h"

@interface CameraListViewController ()

@property (nonatomic, strong) UIImage *temporaryImage;

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
	// Do any additional setup after loading the view.
    self.title = @"Cameras";
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://cameras.sensor.nevada.edu/vid.cgi?id=S48_CCTH&doc=Snake%20Range%20Sagebrush%20West&i=1&r=0.5450507930945605"]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            self.temporaryImage = [[UIImage alloc] initWithData:data];
            
            NSLog(@"data\n%@", data);
            
            [self.collectionView reloadData];
        }
        
        if (connectionError) {
            NSLog(@"%@", connectionError.userInfo);
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CameraPreviewCell" forIndexPath:indexPath];
    [[(CameraPreviewCell*)cell imageView] setImage:self.temporaryImage];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected");
}

@end
