//
//  Camera.m
//  Sensors
//
//  Created by John Jusayan on 12/16/13.
//  Copyright (c) 2013 CSE UNR All rights reserved.
//

#import "Camera.h"
#import "Image.h"
#import "NSString+SCURLParsing.h"


@implementation Camera

@dynamic groupName;
@dynamic name;
@dynamic orderIndex;
@dynamic thumbnailImage;
@dynamic baseURL;
@dynamic images;

- (NSArray*)photoURLsFordataString:(NSString*)dataString;
{
    NSArray *fileNames = [dataString sc_photoFileNamesFromDataString];
    NSMutableArray *photoURLs = [NSMutableArray new];
    
    [fileNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *fileURLString = (NSString*)obj;
        fileURLString = [self.baseURL stringByAppendingPathComponent:fileURLString];
        [photoURLs addObject:fileURLString];
    }];
    
    return photoURLs;
}

@end
