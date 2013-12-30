//
//  NSString+SCURLParsing.m
//  Sensors
//
//  Created by John Jusayan on 12/11/13.
//  Copyright (c) 2013 CSE UNR All rights reserved.
//

#import "NSString+SCURLParsing.h"

@implementation NSString (SCURLParsing)

- (NSArray*)sc_photoFileNamesFromDataString
{
    NSMutableArray *photoFileNames = [NSMutableArray new];
    NSArray *lines =  [self componentsSeparatedByString:@"\r\n"];
    
    [lines enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *fileName = [[obj componentsSeparatedByString:@" "] lastObject];
        
        if (fileName && [fileName hasPrefix:@"p"] && [fileName hasSuffix:@".jpg"]) {
            [photoFileNames addObject:fileName];
        }
    }];
    return photoFileNames;
}

@end
