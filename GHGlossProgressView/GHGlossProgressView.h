//
//  GHGlossProgressView.h
//  GHGlossProgressView
//
//  Created by Oliver Letterer on 09.08.11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GHGlossProgressView : UIView {
@private
    CGFloat _progress;
	
    BOOL _hidesWithoutProgress;
    
	UIColor *_tintColor;
    CGGradientRef _backgroundGradient;  // retained
}

- (void)setBackgroundGradient:(CGGradientRef)backgroundGradient;
- (CGGradientRef)backgroundGradient;

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, retain) UIColor *tintColor;

@property (nonatomic, assign) BOOL hidesWithoutProgress;

@end
