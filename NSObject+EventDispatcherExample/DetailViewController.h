//
//  DetailViewController.h
//  NSObject+EventDispatcherExample
//
//  Created by noughts on 2014/02/11.
//  Copyright (c) 2014年 noughts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
