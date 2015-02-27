//
//  TableViewController.h
//  BlogReader
//
//  Created by Claire on 2/17/15.
//  Copyright (c) 2015 Jencks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController

@property (strong, nonatomic) NSArray *sectionTitles; //array of strings
@property (strong, nonatomic) NSMutableArray *blogPosts; //array of dictionaries
@property (strong, nonatomic) NSArray *titles;

@end
