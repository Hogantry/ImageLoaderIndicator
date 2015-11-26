//
//  DFZCustomImageView.m
//  ImageLoaderIndicator
//
//  Created by DFZ on 15/11/25.
//  Copyright © 2015年 DFZ. All rights reserved.
//

#import "DFZCustomImageView.h"
#import "DFZCircularLoaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DFZCustomImageView ()

@property (nonatomic, weak) DFZCircularLoaderView *loaderView;

@end

@implementation DFZCustomImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        DFZCircularLoaderView *loaderView = [[DFZCircularLoaderView alloc] initWithFrame:self.bounds];
        self.loaderView = loaderView;
        [self addSubview:loaderView];
        loaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        NSURL *url = [NSURL URLWithString:@"http://www.raywenderlich.com/wp-content/uploads/2015/02/mac-glasses.jpeg"];
        __weak __typeof(self) weakSelf = self;
        [self sd_setImageWithURL:url placeholderImage:nil options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.loaderView.progress = (CGFloat)receivedSize / expectedSize;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.loaderView reveal];
        }];
    }
    return self;
}

@end
