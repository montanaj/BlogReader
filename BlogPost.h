//
//  BlogPost.h
//  BlogReader
//
//  Created by Claire on 2/18/15.
//  Copyright (c) 2015 Jencks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogPost : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *thumbnail;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSURL *url;

//dedicated initializer
-(id)initWithTitle:(NSString *)title;
+(id)blogPostWithTitle:(NSString *)title;
-(NSURL *)thumbnailURL;
-(NSString *)formattedDate;



/*
{
    NSString *title;
    NSString *author;
}

-(NSString *)title;
-(void)setTitle:(NSString *)_title;

//@property replaces the setter and getter (behind the scenes)
//it is a facade to access the instance variable
//using properties, when we reference self we are accessing the setter and getter methods of that class
//atomic is for a multi-threaded environment
//nonatomic provides faster access in single-thread environment
*/


@end
