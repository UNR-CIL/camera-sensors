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

@interface CameraDetailViewController ()

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
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString:[self.detailCamera baseURL]]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSArray *photoURLs = [dataString sc_photoFileNamesFromDataString];
            
            [photoURLs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSURL *imageURL = [NSURL URLWithString:[self.detailCamera.baseURL stringByAppendingPathComponent:obj]];
                NSLog(@">>> imageURL %@", imageURL);
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

@end
