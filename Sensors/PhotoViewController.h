//
//  PhotoViewController.h
//  Sensors
//
//  Created by John Jusayan on 1/1/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController

+ (PhotoViewController *)photoViewController;
@property (nonatomic, strong) UIImage *image;
@end
