//
//  BlogPost.m
//  BlogReader
//
//  Created by Claire on 2/18/15.
//  Copyright (c) 2015 Jencks. All rights reserved.
//

#import "BlogPost.h"

@implementation BlogPost
/*
-(NSString *)title {
    return title;
}

-(void)setTitle:(NSString *)_title {
    title = _title;
}
*/

//A designated initializer has the primary responsibility for initializing new instances of a class.

-(id)initWithTitle:(NSString *)title {
    //initlize self using methods in our parent class (NSObject)
    self = [super init];
    //check it is not nil
    if  (self){

        self.title = title;
        self.author = nil;
        self.thumbnail = nil;
    }

    return self;
}
//convenience constructor- method that allocates and initializes in one step and returns an instance

+(id)blogPostWithTitle:(NSString *)title {
    return [[self alloc] initWithTitle:title];
}
/*
//the difference is: initializer method
BlogPost *blogPost2 = [[BlogPost alloc] initWithTitle:@"Hey Title" andAuthor:@"Hey Author"];
//using convenience method (alloc/init in one step)
BlogPost *blogPost3 = [BlogPost blogPostWithTitle:@"Hey Title" andAuthor:@"Hey Author"];
*/

-(NSURL *)thumbnailURL {
     return [NSURL URLWithString:self.thumbnail];
}

-(NSString *)formattedDate {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *tempDate = [dateFormatter dateFromString:self.date];

    [dateFormatter setDateFormat:@"EE MMM, dd"];
    return [dateFormatter stringFromDate:tempDate];
}


@end
