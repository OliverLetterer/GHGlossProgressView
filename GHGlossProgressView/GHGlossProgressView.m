//
//  GHGlossProgressView.m
//  GHGlossProgressView
//
//  Created by Oliver Letterer on 09.08.11.
//  Copyright 2011 Home. All rights reserved.
//

#import "GHGlossProgressView.h"
#import "CGCommon.h"



@interface GHGlossProgressView () {
@private
    UIColor *_glossTintColor;
}

@property (nonatomic, retain) UIColor *glossTintColor;
- (void)_recacheGlossTintColor;

@end





@implementation GHGlossProgressView
@synthesize progress=_progress;
@synthesize glossTintColor=_glossTintColor, tintColor=_tintColor, hidesWithoutProgress=_hidesWithoutProgress;

#pragma mark - setters and getters

- (void)setBackgroundGradient:(CGGradientRef)backgroundGradient {
    if (backgroundGradient != _backgroundGradient) {
        if (_backgroundGradient) {
            CGGradientRelease(_backgroundGradient), _backgroundGradient = NULL;
        }
        if (backgroundGradient) {
            _backgroundGradient = CGGradientRetain(backgroundGradient);
        }
        
        [self setNeedsDisplay];
    }
}

- (CGGradientRef)backgroundGradient {
    return _backgroundGradient;
}

- (void)setHidesWithoutProgress:(BOOL)hidesWithoutProgress {
    if (hidesWithoutProgress != _hidesWithoutProgress) {
        _hidesWithoutProgress = hidesWithoutProgress;
        
        if (_hidesWithoutProgress) {
            if (_progress == 0.0f) {
                self.alpha = 0.0f;
            } else {
                self.alpha = 1.0f;
            }
        } else {
            self.alpha = 1.0f;
        }
    }
}

- (void)setTintColor:(UIColor *)tintColor {
	if (tintColor != _tintColor) {
        if (CGColorSpaceGetModel(CGColorGetColorSpace(tintColor.CGColor)) != kCGColorSpaceModelRGB) {
            [NSException raise:NSInvalidArgumentException format:@"tintColor (%@) must be a RBG color", tintColor];
        }
		_tintColor = tintColor;
		[self _recacheGlossTintColor];
		[self setNeedsDisplay];
	}
}

- (void)setProgress:(CGFloat)progress {
    if (progress < 0.0f) {
        progress = 0.0f;
    } else if (progress > 1.0f) {
        progress = 1.0f;
    }
    
    if (progress != _progress) {
        _progress = progress;
        
        if (_hidesWithoutProgress) {
            if (_progress == 0.0f) {
                self.alpha = 0.0f;
            } else {
                self.alpha = 1.0f;
            }
        } else {
            self.alpha = 1.0f;
        }
        
        [self setNeedsDisplay];
    }
}

- (void)setFrame:(CGRect)frame {
    CGRect bounds = self.bounds;
    [super setFrame:frame];
    
    if (CGRectGetHeight(bounds) != CGRectGetHeight(self.bounds)) {
        [self _recacheGlossTintColor];
    }
    
    if (!CGRectEqualToRect(bounds, self.bounds)) {
        [self setNeedsDisplay];
    }
}

#pragma mark - private

- (void)_recacheGlossTintColor {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1.0f, CGRectGetHeight(self.bounds)), NO, [UIScreen mainScreen].scale);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	GHDrawGlossGradient(ctx, _tintColor.CGColor, CGRectMake(0.0f, 0.0f, 1.0f, CGRectGetHeight(self.bounds)));
	
	UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	self.glossTintColor = [UIColor colorWithPatternImage:backgroundImage];
}

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		super.backgroundColor = [UIColor clearColor];
        
        // setup default tintColor
		self.tintColor = [UIColor colorWithRed:20.0f/255.0f green:51.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        
        // setup some default background
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
        
        NSArray *colors = [NSArray arrayWithObjects:
                           (__bridge id)[UIColor colorWithWhite:0.0f alpha:1.0f].CGColor, 
                           (__bridge id)[UIColor colorWithWhite:0.345f alpha:1.0f].CGColor, 
                           nil];
        
        CGFloat locations[] = {0.0f, 1.0f};
        CGGradientRef backgroundGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
        self.backgroundGradient = backgroundGradient;
        
        CGGradientRelease(backgroundGradient);
        CGColorSpaceRelease(colorSpace);
    }
    return self;
}

#pragma mark - Drawing

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// draw the background
	CGContextSaveGState(context);
    UIBezierPath *outerPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:CGRectGetHeight(rect)/2.0f];
    [outerPath addClip];
    
    CGPoint backgroundStartPoint = CGPointMake(0.0f, 0.0f);
    CGPoint backgroundEndPoint = CGPointMake(0.0f, CGRectGetHeight(rect));
    CGContextDrawLinearGradient(context, _backgroundGradient, backgroundStartPoint, backgroundEndPoint, 0);
	
	CGContextRestoreGState(context);
	
	// draw the progress
	CGContextSaveGState(context);
    UIBezierPath *innerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 1.0f, 1.0f) cornerRadius:CGRectGetHeight(rect)/2.0f - 1.0f];
    [innerPath addClip];
	
    [_glossTintColor setFill];
    CGRect progressRect = CGRectMake(0, 0, CGRectGetWidth(rect)*_progress, CGRectGetHeight(rect));
	CGContextFillRect(context, progressRect);
	
	CGContextRestoreGState(context);
}

#pragma mark - Memory management

- (void)dealloc {
    if (_backgroundGradient) {
        CGGradientRelease(_backgroundGradient);
    }
}

@end
