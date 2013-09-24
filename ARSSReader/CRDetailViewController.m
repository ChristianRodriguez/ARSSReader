//
//  CRDetailViewController.m
//  ARSSReader
//
//  Created by Christian Rodriguez on 4/14/13.
//  Copyright (c) 2013 Christian Rodriguez. All rights reserved.
//


#import "CRDetailViewController.h"
#import "RSSItem.h"

@interface CRDetailViewController ()
{
    IBOutlet UIWebView* webView;
}
@end

@implementation CRDetailViewController

-(void)viewDidAppear:(BOOL)animated
{
    RSSItem* item = (RSSItem*)self.detailItem;
    self.title = item.title;
    //webView.delegate = self;
    NSURLRequest* articleRequest = [NSURLRequest requestWithURL: item.link];
    webView.backgroundColor = [UIColor clearColor];
    [webView loadRequest: articleRequest];
}

-(void)viewDidDisappear:(BOOL)animated
{
    webView.delegate = nil;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

@end
