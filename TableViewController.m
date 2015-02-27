//
//  TableViewController.m
//  BlogReader
//
//  Created by Claire on 2/17/15.
//  Copyright (c) 2015 Jencks. All rights reserved.
//

#import "TableViewController.h"
#import "WebViewController.h"
#import "BlogPost.h"
#import "JSONSerializer.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.title = @"Blogs";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];

    //initializing tableviewcontroller blogPost Array
    self.blogPosts = [NSMutableArray array];

    //json serializer returns a dictionary
    JSONSerializer *jsonSerializer = [JSONSerializer new];
    NSDictionary * blogDict = [jsonSerializer jsonSerializer:@"http://blog.teamtreehouse.com/api/get_recent_summary/"];

    //store serialized posts in local array
    NSArray *blogPostArray = [blogDict objectForKey:@"posts"];
    NSLog(@"blogPosts:%@", blogPostArray);
    
    //iterate through array of dictionaries
    for (NSDictionary *blogPostDictionary in blogPostArray) {
        //use the convenience constructor to alloc init with title;
        BlogPost *blogPost = [BlogPost blogPostWithTitle:[blogPostDictionary objectForKey:@"title"]];
        //get values for all properties of the blogPost instance
        blogPost.author = [blogPostDictionary objectForKey:@"author"];
        blogPost.thumbnail = [blogPostDictionary objectForKey:@"thumbnail"];
        blogPost.date = [blogPostDictionary objectForKey:@"date"];
        blogPost.url = [NSURL URLWithString:[blogPostDictionary objectForKey:@"url"]];
        //add this new object to the tableview array
        [self.blogPosts addObject:blogPost];
    }

    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.userInteractionEnabled = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
    //self.sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.blogPosts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];

    BlogPost *blogPost = [self.blogPosts objectAtIndex:indexPath.row];

    //Class Check - w/o this, the class could be null and crash the app
    if ([blogPost.thumbnail isKindOfClass:[NSString class]]) {
        NSData *data = [NSData dataWithContentsOfURL:blogPost.thumbnailURL];
        UIImage *image = [UIImage imageWithData:data];
        cell.imageView.image = image;
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"pig.png"];
    }

    cell.textLabel.text = blogPost.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Author: %@ Date: %@", blogPost.author, [blogPost formattedDate]];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
    //self.sectionTitles[section];
}

#pragma mark TableView Delegate

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexpath.row:%ld", (long)indexPath.row);
    BlogPost *blogPost = [self.blogPosts objectAtIndex:indexPath.row];

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].

    // Pass the selected object to the new view controller.
    NSLog(@"segue:%@", segue.identifier);

    if ([segue.identifier isEqual:@"showWeb"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        BlogPost *blogPost = [self.blogPosts objectAtIndex:indexPath.row];

        [segue.destinationViewController setBlogPostURL:blogPost.url];
    }
}

@end
