//
//  CRDetailViewController.h
//  ARSSReader
//
//  Created by Christian Rodriguez on 4/14/13.
//  Copyright (c) 2013 Christian Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
