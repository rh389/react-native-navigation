//
//  RCCTitleView.m
//  ReactNativeNavigation
//
//  Created by Ran Greenberg on 26/04/2017.
//  Copyright © 2017 artal. All rights reserved.
//

#import "RCCCustomTitleView.h"

@interface RCCCustomTitleView ()
@property (nonatomic, strong) UIView *subView;
@property (nonatomic, strong) NSString *subViewAlign;
@end

@implementation RCCCustomTitleView


-(instancetype)initWithFrame:(CGRect)frame subView:(UIView*)subView alignment:(NSString*)alignment {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.subView = subView;
        self.subViewAlign = alignment;
        
        subView.frame = self.bounds;
        [self addSubview:subView];
    }
    
    return self;
}


-(void)layoutSubviews {
    [super layoutSubviews];
    
    if ([self.subViewAlign isEqualToString:@"fill"]) {
        self.subView.frame = self.bounds;
    }
    else {
        CGFloat superViewWidth = self.superview.frame.size.width;
        CGFloat navBarWidth = self.superview.superview.frame.size.width;
        CGFloat leftButtonWidth = self.superview.frame.origin.x;
        CGFloat rightButtonWidth = navBarWidth - superViewWidth - leftButtonWidth;
        if (rightButtonWidth == 0) {
            return;
        }

        CGFloat padLeft = 0;
        CGFloat padRight = 0;
        if (leftButtonWidth > rightButtonWidth) {
            padRight = leftButtonWidth - rightButtonWidth;
        } else {
            padLeft = rightButtonWidth - leftButtonWidth;
        }

        CGRect reactViewFrame = self.subView.frame;
        reactViewFrame.size.width = navBarWidth - leftButtonWidth - rightButtonWidth - padLeft - padRight;
        reactViewFrame.origin.x = padLeft;
        self.subView.frame = reactViewFrame;
    }
}

@end
