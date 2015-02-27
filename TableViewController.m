//
//  TableViewController.m
//  BlogReader
//
//  Created by Claire on 2/17/15.
//  Copyright (c) 2015 Jencks. All rights reserved.
//

#import "TableViewController.h"
#import "BlogPost.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    NSError *error = nil;
    //create url object with call - usally local file! Will block thread.
    NSURL *url = [NSURL URLWithString:@"http://blog.teamtreehouse.com/api/get_recent_summary/"];

    //Create data object with whatever url returns
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    NSLog(@"jsondata:%@", jsonData);

    //serialize JSON into Dictionary
    NSDictionary *blogDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

    NSLog(@"jsonData = %@, blogDict %@",jsonData,blogDict);

    self.blogPosts = [NSMutableArray array];

    NSArray *blogPostArray = [blogDict objectForKey:@"posts"];
    NSLog(@"blogPosts:%@", blogPostArray);

    for (NSDictionary *blogPostDictionary in blogPostArray) {
        BlogPost *blogPost = [BlogPost blogPostWithTitle:[blogPostDictionary objectForKey:@"title"]];
        blogPost.author = [blogPostDictionary objectForKey:@"author"];
        blogPost.thumbnail = [blogPostDictionary objectForKey:@"thumbnail"];
        blogPost.date = [blogPostDictionary objectForKey:@"date"];
        [self.blogPosts addObject:blogPost];
    }

    self.sectionTitles = @[@"Improv Nerd", @"Wine Night"];

    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.backgroundColor = [UIColor blueColor];
    
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
    
//    for (NSInteger g =0 ; g < self.sectionTitles.count; g++) {
//        cell.textLabel.text = [[self.blogPosts objectAtIndex:indexPath.row]objectForKey:@"title"];
//        cell.detailTextLabel.text = [[self.blogPosts objectAtIndex:indexPath.row]objectForKey:@"author"];
//    }
    BlogPost *blogPost = [self.blogPosts objectAtIndex:indexPath.row];
    if ([blogPost.thumbnail isKindOfClass:[NSString class]]) {
        NSData *data = [NSData dataWithContentsOfURL:blogPost.thumbnailURL];
        UIImage *image = [UIImage imageWithData:data];

        cell.imageView.image = image;

    }
    else cell.imageView.image = [UIImage imageNamed:@"pig.png"];

    cell.textLabel.text = blogPost.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Author: %@ Date: %@", blogPost.author, [blogPost formattedDate]];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
    //self.sectionTitles[section];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
