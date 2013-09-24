//
//  RSSItem.m
//  ARSSReader
//
//  Created by Christian Rodriguez on 4/14/13.
//  Copyright (c) 2013 Christian Rodriguez. All rights reserved.
//

#import "RSSItem.h"
#import "GTMNSString+HTML.h"

@implementation RSSItem

-(NSAttributedString*)cellMessage
{
    if (_cellMessage!=nil) return _cellMessage;
    // gives article title 16pt helvitica bold
    NSDictionary* boldStyle = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:16.0]};
    // same thing without bold
    NSDictionary* normalStyle = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:16.0]};
    // loads article into mutable string
    NSMutableAttributedString* articleAbstract = [[NSMutableAttributedString alloc] initWithString:self.title];
    // adds bold
    [articleAbstract setAttributes:boldStyle
                             range:NSMakeRange(0, self.title.length)];
    
    [articleAbstract appendAttributedString:
     [[NSAttributedString alloc] initWithString:@"\n\n"]
     ];
    //
    int startIndex = [articleAbstract length];
    
    NSString* description = [NSString stringWithFormat:@"%@...", [self.description substringToIndex:100]];
    description = [description gtm_stringByUnescapingFromHTML];
    
    
    [articleAbstract appendAttributedString:
     [[NSAttributedString alloc] initWithString: description]
     ];
    
    [articleAbstract setAttributes:normalStyle
                             range:NSMakeRange(startIndex, articleAbstract.length - startIndex)];
    
    _cellMessage = articleAbstract;
    return _cellMessage;
   
}

@end

