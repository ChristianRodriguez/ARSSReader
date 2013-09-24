//
//  RSSItem.h
//  ARSSReader
//
//  Created by Christian Rodriguez on 4/14/13.
//  Copyright (c) 2013 Christian Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSItem : NSObject

/*
 * Fetches title, description, and link and stores the instance variables  of this class
 * Also cell message provides a text for the cell row
 */

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* description;
@property (strong, nonatomic) NSURL* link;
@property (strong, nonatomic) NSAttributedString* cellMessage;


@end
