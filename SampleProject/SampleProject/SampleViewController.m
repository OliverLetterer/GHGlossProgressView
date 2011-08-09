//
//  SampleViewController.m
//  SampleProject
//
//  Created by Oliver Letterer on 09.08.11.
//  Copyright 2011 Home. All rights reserved.
//

#import "SampleViewController.h"
#import "GHGlossProgressView.h"

@implementation SampleViewController

#pragma mark - View lifecycle

- (void)loadView {
    [super loadView];
    
    NSArray *colors = [NSArray arrayWithObjects:
                       [UIColor orangeColor], 
                       [UIColor colorWithRed:20.0f/255.0f green:51.0f/255.0f blue:255.0f/255.0f alpha:1.0f], 
                       [UIColor redColor], 
                       [UIColor yellowColor], 
                       [UIColor greenColor], 
                       [UIColor purpleColor], 
                       nil];
    
    [colors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIColor *tintColor = obj;
        
        GHGlossProgressView *progressView = [[GHGlossProgressView alloc] initWithFrame:CGRectMake(10.0f, 60.0f * idx + 10.0f, CGRectGetWidth(self.view.bounds) - 20.0f, 50.0f)];
        progressView.tintColor = tintColor;
        progressView.progress = 0.5f;
        progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:progressView];
    }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

@end
