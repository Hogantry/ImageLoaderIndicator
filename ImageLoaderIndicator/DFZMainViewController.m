//
//  DFZMainViewController.m
//  ImageLoaderIndicator
//
//  Created by DFZ on 15/11/25.
//  Copyright © 2015年 DFZ. All rights reserved.
//

#import "DFZMainViewController.h"
#import "DFZCustomImageView.h"

@implementation DFZMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    DFZCustomImageView *customImageView = [[DFZCustomImageView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 200)];
    DFZCustomImageView *customImageView = [[DFZCustomImageView alloc] init];
    customImageView.frame = CGRectMake(0, 180, self.view.frame.size.width, 200);
//    customImageView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:customImageView];
    
//    CAShapeLayer *shapLayer = [[CAShapeLayer alloc] init];
//    shapLayer.backgroundColor = [UIColor greenColor].CGColor;
//    shapLayer.frame = CGRectMake(0, 400, self.view.frame.size.width, 200);
//    shapLayer.lineWidth = 200.0;
//    shapLayer.fillColor = [UIColor blueColor].CGColor;
//    shapLayer.strokeColor = [UIColor redColor].CGColor;
//    shapLayer.strokeStart   = 0.0f;
//    shapLayer.strokeEnd     = 1.0f;
//    shapLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 200)].CGPath;
//    [self.view.layer addSublayer:shapLayer];
}

@end
