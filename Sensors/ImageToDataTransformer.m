//
//  ImageToDataTransformer.m
//  Sensors
//
//  Created by John Jusayan on 7/28/11.
//  Copyright (c) 2013 CSE UNR All rights reserved.
//

#import "ImageToDataTransformer.h"

@implementation ImageToDataTransformer

+ (BOOL)allowsReverseTransformation
{
	return YES;
}

+ (Class)transformedValueClass
{
	return [NSData class];
}


- (id)transformedValue:(id)value
{
    NSData *data = UIImagePNGRepresentation(value);
	return data;
}


- (id)reverseTransformedValue:(id)value
{
	return [[UIImage alloc] initWithData:value];
}

@end
