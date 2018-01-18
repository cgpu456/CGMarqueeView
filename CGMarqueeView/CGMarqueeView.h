//
//  CGMarqueeView.h
//  CPFrameworkDemos
//
//  Created by Chenp on 2018/1/18.
//  Copyright © 2018年 TestDemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGMarqueeView : UIView

@property (nonatomic, strong) UILabel *displayLabel;
@property (nonatomic) NSTimeInterval duration;

- (void)showInView:(UIView *)view;

@end
