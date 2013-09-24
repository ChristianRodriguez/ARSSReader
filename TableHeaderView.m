//
//  TableHeaderView.m
//  ARSSReader
//
//  Created by Christian Rodriguez on 4/14/13.
//  Copyright (c) 2013 Christian Rodriguez. All rights reserved.
//

#import "TableHeaderView.h"

@interface TableHeaderView()
{
    UILabel* label;
}
@end

@implementation TableHeaderView

- (id)initWithText:(NSString*)text
{
    //sets custom ui image
    UIImage* img = [UIImage imageNamed:@"arss_header.png"];
    if ((self = [super initWithImage:img])) {
        // Initialization code
        label = [[UILabel alloc] initWithFrame:CGRectMake(50,10,200,100)];
        label.textColor = [UIColor whiteColor];
        label.shadowColor = [UIColor grayColor];
        label.shadowOffset = CGSizeMake(1, 1);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:20];
        label.text = text;
        label.numberOfLines = 2;
        [self addSubview:label];
    }
    return self;
}

- (void)setText:(NSString*)text
{
    label.text = text;
}

@end