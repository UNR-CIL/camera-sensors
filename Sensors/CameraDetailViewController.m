//
//  CameraDetailViewController.m
//  Sensors
//
//  Created by John Jusayan on 12/30/13.
//  Copyright (c) 2013 Treeness, LLC. All rights reserved.
//

#import "CameraDetailViewController.h"

#import "Camera.h"
#import "NSString+SCURLParsing.h"
#import "CameraPreviewCell.h"

@interface CameraDetailViewController ()

@property (strong, nonatomic) NSArray *imageURLs;
@property (strong, nonatomic) NSMutableArray *images;

@end

@implementation CameraDetailViewController

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
    
    self.images = [NSMutableArray new];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString:[self.detailCamera baseURL]]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSArray *photoURLs = [dataString sc_photoFileNamesFromDataString];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.imageURLs = photoURLs;
                
                [self.imageURLs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    NSURL *imageURL = [NSURL URLWithString:[self.detailCamera.baseURL stringByAppendingPathComponent:obj]];
                    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:imageURL];
                    
                    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                        if (data) {
                            UIImage *image = [[UIImage alloc] initWithData:data];
                            
                            if (image) {
                                [self.images addObject:image];
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
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CameraPreviewCell" forIndexPath:indexPath];

    UIImage *image = [self.images objectAtIndex:indexPath.row];
    [[(CameraPreviewCell*)cell imageView] setImage:image];
    
    return cell;
}


@end
