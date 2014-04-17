//
//  PhotoViewController.m
//  Sensors
//
//  Created by John Jusayan on 1/1/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import "PhotoViewController.h"
#import "ImageScrollView.h"

@interface PhotoViewController ()
{
    NSUInteger _pageIndex;
}
@end

@implementation PhotoViewController

+ (PhotoViewController *)photoViewController
{
    return [[self alloc] initWithPageIndex:0];
    return nil;
}

- (id)initWithPageIndex:(NSInteger)pageIndex
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
    }
    return self;
}


- (void)loadView
{
    ImageScrollView *scrollView = [[ImageScrollView alloc] init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view = scrollView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"Photo";
    [(ImageScrollView*)self.view displayImage:self.image];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
        self.navigationItem.rightBarButtonItem = doneButton;
    }    
}

- (IBAction)done:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// (this can also be defined in Info.plist via UISupportedInterfaceOrientations)
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

@end
