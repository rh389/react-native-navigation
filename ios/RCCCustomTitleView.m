//
//  RCCTitleView.m
//  ReactNativeNavigation
//
//  Created by Ran Greenberg on 26/04/2017.
//  Copyright © 2017 artal. All rights reserved.
//

#import "RCCCustomTitleView.h"
#import <React/RCTRootViewDelegate.h>
#import <React/RCTRootView.h>

@interface RCCCustomTitleView () <RCTRootViewDelegate>
@property (nonatomic, strong) RCTRootView *subView;
@property (nonatomic, strong) NSString *subViewAlign;
@end

@implementation RCCCustomTitleView

-(instancetype)initWithFrame:(CGRect)frame subView:(RCTRootView*)subView alignment:(NSString*)alignment {
    self = [super initWithFrame:frame];

    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.subView = subView;
        self.subViewAlign = alignment;
        if ([alignment isEqualToString:@"center"]) {
            if (@available(iOS 11, *)) {
                subView.sizeFlexibility = RCTRootViewSizeFlexibilityWidthAndHeight;
                subView.delegate = self;
                self.frame = CGRectZero;
            } else {
                subView.frame = self.bounds;
            }
        } else {
            subView.frame = self.bounds;
        }
        [self addSubview:subView];
    }

    return self;
}

- (void)rootViewDidChangeIntrinsicSize:(RCTRootView *)rootView {
    if (@available(iOS 11, *)) {
        if ([self.subViewAlign isEqualToString:@"center"]) {
            CGSize size = rootView.intrinsicContentSize;
            rootView.frame = CGRectMake(0, 0, size.width, size.height);
            self.frame = rootView.frame;
        }
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];

    if ([self.subViewAlign isEqualToString:@"fill"]) {
        self.subView.frame = self.bounds;
    }
    else {
        if (@available(iOS 11, *)) {
            // No action required, but @available cannot be negated
        } else {
            CGFloat leftButtonWidth = self.frame.origin.x;
            CGFloat navBarWidth = self.superview.superview.frame.size.width;
            CGFloat superViewWidth = self.superview.frame.size.width;
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
}

@end
