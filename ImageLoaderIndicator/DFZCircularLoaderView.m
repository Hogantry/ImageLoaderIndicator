//
//  DFZCircularLoaderView.m
//  ImageLoaderIndicator
//
//  Created by DFZ on 15/11/25.
//  Copyright © 2015年 DFZ. All rights reserved.
//

#import "DFZCircularLoaderView.h"

@interface DFZCircularLoaderView ()

@property (nonatomic, weak) CAShapeLayer *circlePathLayer;
@property (nonatomic, assign) CGFloat circleRadius;

@end

@implementation DFZCircularLoaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure {
    CAShapeLayer *circlePathLayer = [[CAShapeLayer alloc] init];
    self.circlePathLayer = circlePathLayer;
    self.circleRadius = 20.0;
    circlePathLayer.frame = self.bounds;
    // CAShapeLayer的线宽，有一半是在尺寸内部，比如本例中，CAShapeLayer是个圆，线宽为2，则线宽的2中有1是在圆内的
    // 因此当设置线宽为半径的2倍时，strokeColor回覆盖掉fillColor
    circlePathLayer.lineWidth = 2.0;
    circlePathLayer.fillColor = [UIColor clearColor].CGColor;
    circlePathLayer.strokeColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:circlePathLayer];
    self.backgroundColor = [UIColor whiteColor];

    _progress = 0;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    if (progress > 1) {
        self.circlePathLayer.strokeEnd = 1;
    } else if (progress < 0) {
        self.circlePathLayer.strokeEnd = 0;
    } else {
        self.circlePathLayer.strokeEnd = progress;
    }
}

- (CGRect)circleFrame {
    CGRect circleFrame = CGRectMake(0, 0, 2 * self.circleRadius, 2 * self.circleRadius);
    circleFrame.origin.x = CGRectGetMidX(self.circlePathLayer.bounds) - CGRectGetMidX(circleFrame);
    circleFrame.origin.y = CGRectGetMidY(self.circlePathLayer.bounds) - CGRectGetMidY(circleFrame);
    return circleFrame;
}

- (UIBezierPath *)circlePath {
    return [UIBezierPath bezierPathWithOvalInRect:[self circleFrame]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.circlePathLayer.frame = self.bounds;
    self.circlePathLayer.path = [self circlePath].CGPath;
}

- (void)reveal {
    self.backgroundColor = [UIColor clearColor];
    self.progress = 1;
    [self.circlePathLayer removeAnimationForKey:@"strokeEnd"];
    [self.circlePathLayer removeFromSuperlayer];
    self.superview.layer.mask = self.circlePathLayer;
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat finalRadius = sqrt((center.x * center.x) + (center.y * center.y));
    CGFloat radiusInset = finalRadius - self.circleRadius;
    CGRect outerRect = CGRectInset([self circleFrame], -radiusInset, -radiusInset);
    CGPathRef toPath = [UIBezierPath bezierPathWithOvalInRect:outerRect].CGPath;

    CGPathRef fromPath = self.circlePathLayer.path;
    CGFloat fromLineWidth = self.circlePathLayer.lineWidth;

    // 执行动画效果，同时改变线宽和半径，通过mask的方式来显示图片
    CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    lineWidthAnimation.fromValue = @(fromLineWidth);
    lineWidthAnimation.toValue = @(2 * finalRadius);
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = (__bridge id _Nullable)(fromPath);
    pathAnimation.toValue = (__bridge id _Nullable)(toPath);

    CAAnimationGroup *groupAnimation = [CAAnimationGroup new];
    groupAnimation.duration = 1.0;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    groupAnimation.animations = @[pathAnimation, lineWidthAnimation];
    groupAnimation.delegate = self;
    [self.circlePathLayer addAnimation:groupAnimation forKey:@"strokeWidth"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.superview.layer.mask = nil;
}

@end
