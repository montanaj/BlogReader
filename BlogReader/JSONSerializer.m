//
//  JSONSerializer.m
//  BlogReader
//
//  Created by Claire on 2/27/15.
//  Copyright (c) 2015 Jencks. All rights reserved.
//

#import "JSONSerializer.h"

@implementation JSONSerializer

-(NSDictionary *)jsonSerializer:(NSString *)urlString {
    NSError *error = nil;
    //create url object with call - usally local file! Will block thread.
    NSURL * url = [NSURL URLWithString:urlString];

    //Create data object with whatever url returns
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    NSLog(@"jsondata:%@", jsonData);

    //serialize JSON into Dictionary
    NSDictionary *blogDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    NSLog(@"jsonData = %@, blogDict %@",jsonData,blogDict);

    return blogDict;
}

@end
