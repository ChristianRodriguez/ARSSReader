//
//  RSSLoader.m
//  ARSSReader
//
//  Created by Christian Rodriguez on 4/14/13.
//  Copyright (c) 2013 Christian Rodriguez. All rights reserved.
//
#import "RSSLoader.h"

#import "RXMLElement.h"
#import "RSSItem.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@implementation RSSLoader

-(void)fetchRssWithURL:(NSURL*)url complete:(RSSLoaderCompleteBlock)c
{
    dispatch_async(kBgQueue, ^{
        
        //work in the background
        RXMLElement *rss = [RXMLElement elementFromURL: url];
        RXMLElement* title = [[rss child:@"channel"] child:@"title"];
        NSArray* items = [[rss child:@"channel"] children:@"item"];
        
        NSMutableArray* result = [NSMutableArray arrayWithCapacity:items.count];
        
        //more code
        for (RXMLElement *e in items) {
            
            //iterate over the articles
            RSSItem* item = [[RSSItem alloc] init];
            item.title = [[e child:@"title"] text];
            item.description = [[e child:@"description"] text];
            item.link = [NSURL URLWithString: [[e child:@"link"] text]];
            [result addObject: item];
        }
        
        c([title text], result);
    });
    
}

@end
