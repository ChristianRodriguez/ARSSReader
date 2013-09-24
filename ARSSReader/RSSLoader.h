//
//  RSSLoader.h
//  ARSSReader
//
//  Created by Christian Rodriguez on 4/14/13.
//  Copyright (c) 2013 Christian Rodriguez. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef void (^RSSLoaderCompleteBlock)(NSString* title, NSArray* results);

@interface RSSLoader : NSObject

-(void)fetchRssWithURL:(NSURL*)url complete:(RSSLoaderCompleteBlock)c;

@end

    
