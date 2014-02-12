//
//  SiteDetailViewController.m
//  Sensors
//
//  Created by John Jusayan on 12/30/13.
//  Copyright (c) 2013 Treeness, LLC. All rights reserved.
//

#import "SiteDetailViewController.h"

#import "Camera.h"
#import "NSString+SCURLParsing.h"
#import "SitePreviewCell.h"

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
    
    self.images = [NSMutableArray new];
    


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
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"SitePreviewCell" forIndexPath:indexPath];

    UIImage *image = [self.images objectAtIndex:indexPath.row];
    [[(SitePreviewCell*)cell imageView] setImage:image];
    
    return cell;
}


@end
