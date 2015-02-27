//
//  WebViewController.h
//  BlogReader
//
//  Created by Claire on 2/27/15.
//  Copyright (c) 2015 Jencks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSURL *blogPostURL;

@end
