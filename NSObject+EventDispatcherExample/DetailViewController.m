//
//  DetailViewController.m
//  NSObject+EventDispatcherExample
//
//  Created by noughts on 2014/02/11.
//  Copyright (c) 2014年 noughts. All rights reserved.
//

#import "DetailViewController.h"
#import "NSObject+EventDispatcher.h"
#import "AppDelegate.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	[self configureView];
	
	AppDelegate* ad = [UIApplication sharedApplication].delegate;
	[ad addEventListener:@"applicationDidEnterBackground:" usingBlock:^(NSNotification *notification) {
		NSLog( @"app did enter background" );
	}];
	[ad addEventListener:@"applicationWillEnterForeground:" usingBlock:^(NSNotification *notification) {
		NSLog( @"app will enter foreground" );
	}];
}

-(void)dealloc{
	AppDelegate* ad = [UIApplication sharedApplication].delegate;
	[ad removeAllEventListener:self];
}


-(IBAction)onButtonTap:(id)sender{
	[self dispatchEvent:@"onButtonTap" userInfo:nil];
}







#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

	if (self.detailItem) {
	    self.detailDescriptionLabel.text = [self.detailItem description];
	}
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
