//
//  CGMarqueeView.m
//  CPFrameworkDemos
//
//  Created by Chenp on 2018/1/18.
//  Copyright © 2018年 TestDemo. All rights reserved.
//

#import "CGMarqueeView.h"

#ifndef CG_SYSTEM_VERSION_LESS_THAN
#define CG_SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#endif

@implementation CGMarqueeView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        _duration = 5.0f;
        _displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_displayLabel];
        
        [_displayLabel addObserver:self
                        forKeyPath:@"text"
                           options:NSKeyValueObservingOptionNew
                           context:nil];
    }
    
    return self;
}

- (void)dealloc {
    [_displayLabel removeObserver:self forKeyPath:@"text"];
}

- (void)layoutSubviews {
    _displayLabel.frame = CGRectMake(0, 0, _displayLabel.frame.size.width, _displayLabel.frame.size.height);
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    
    if ([keyPath isEqualToString:@"text"]) {
        
        NSString *text = [change valueForKey:NSKeyValueChangeNewKey];
        if ((text == nil) || (text.length <= 0)) {
            return;
        }
        
        CGSize size = [self sizeWithFont:_displayLabel.font string:_displayLabel.text];
        CGRect newFrame = _displayLabel.frame;
        newFrame.size.width = size.width;
        _displayLabel.frame = newFrame;
    }
}

#pragma mark - Public
- (void)showInView:(UIView *)view {
    
    if (!view || ![view isKindOfClass:[UIView class]]) {
        return;
    }
    
    if (![view.subviews containsObject:self]) {
        [view addSubview:self];
    }
    
    [self performSelector:@selector(startAnimation)
               withObject:nil
               afterDelay:0.5f];
}


#pragma mark - Private
- (CGSize)sizeWithFont:(UIFont *)font string:(NSString *)string {
    
    CGSize size;
    
    if (CG_SYSTEM_VERSION_LESS_THAN(@"7.0")) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        size = [string sizeWithFont:font
                  constrainedToSize:CGSizeMake(1000, 200)
                      lineBreakMode:0];
#pragma clang diagnostic pop
    } else {
        NSDictionary * attDic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
        size = [string boundingRectWithSize:CGSizeMake(1000, 200)
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:attDic
                                    context:nil].size;
    }
    
    return size;
}


- (void)startAnimation {
    if ((_displayLabel.text.length <= 0) || (_displayLabel.frame.size.width <= self.frame.size.width)) {
        return;
    }
    
    [UIView animateWithDuration:_duration delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect lableFrame = _displayLabel.frame;
        if (lableFrame.origin.x == 0) {
            lableFrame.origin.x = -(lableFrame.size.width - self.frame.size.width);
        } else if (lableFrame.origin.x < 0) {
            lableFrame.origin.x = 0;
        }
        
        [_displayLabel setFrame:lableFrame];
    } completion:^(BOOL finished) {
        [self performSelector:@selector(startAnimation)
                   withObject:nil
                   afterDelay:0.5f];
    }];
}

@end
