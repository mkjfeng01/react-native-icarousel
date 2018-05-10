//
//  RCTiCarousel.m
//  RNiCarousel
//
//  Created by 张锋 on 05/12/2017.
//  Copyright © 2017 张锋. All rights reserved.
//

#import "RCTiCarousel.h"
#import "RCTCardView.h"
#if __has_include(<React/UIView+React.h>)
#import <React/UIView+React.h>
#import <React/RCTLog.h>
#else
#import "UIView+React.h"
#import "RCTLog.h"
#endif

static const NSDictionary<NSString *, NSNumber *> * iCarouselOptionConvertionFactory;

@implementation RCTiCarousel

#pragma mark - Life Circle

+ (void)load {
    iCarouselOptionConvertionFactory = @{
                                         @"iCarouselOptionWrap" : @(iCarouselOptionWrap),
                                         @"iCarouselOptionShowBackfaces" : @(iCarouselOptionShowBackfaces),
                                         @"iCarouselOptionOffsetMultiplier" : @(iCarouselOptionOffsetMultiplier),
                                         @"iCarouselOptionVisibleItems" : @(iCarouselOptionVisibleItems),
                                         @"iCarouselOptionCount" : @(iCarouselOptionCount),
                                         @"iCarouselOptionArc" : @(iCarouselOptionArc),
                                         @"iCarouselOptionAngle" : @(iCarouselOptionAngle),
                                         @"iCarouselOptionRadius" : @(iCarouselOptionRadius),
                                         @"iCarouselOptionTilt" : @(iCarouselOptionTilt),
                                         @"iCarouselOptionSpacing" : @(iCarouselOptionSpacing),
                                         @"iCarouselOptionFadeMin" : @(iCarouselOptionFadeMin),
                                         @"iCarouselOptionFadeMax" : @(iCarouselOptionFadeMax),
                                         @"iCarouselOptionFadeRange" : @(iCarouselOptionFadeRange),
                                         @"iCarouselOptionFadeMinAlpha" : @(iCarouselOptionFadeMinAlpha)
                                         };
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        _items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)insertReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex {
    [super insertReactSubview:subview atIndex:atIndex];
    
    [self.items insertObject:subview atIndex:atIndex];
    [self reloadData];
}

#pragma mark - Setters
    
- (void)setItems:(NSMutableArray *)items {
    _items = items;
    [self reloadData];
}

#pragma mark - iCarouselDataSource
    
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return [self.items count];
}
    
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    if (index < [self.items count]) {
        return [self.items objectAtIndex:index];
    }
    return nil;
}

#pragma mark - iCarouselDelegate

- (void)carouselCurrentItemIndexDidChange:(RCTiCarousel *)carousel {
    NSString *title = @"";
    
    id item = carousel.currentItemView;
    if ([item isKindOfClass:[RCTCardView class]] && [item title]) {
        title = [(RCTCardView *)carousel.currentItemView title];
    } else {
        RCTLogInfo(@"🔴 方法：%s，所在行：%zd，描述：无法识别的卡片控件或者没有设置标题", __FUNCTION__, __LINE__);
    }
    
    NSDictionary *body = @{
                           @"target" : carousel.reactTag,
                           @"title" : title,
                           @"index" : [NSNumber numberWithInteger:carousel.currentItemIndex]
                           };
    !carousel.onCurrentItemIndexDidChange ?: carousel.onCurrentItemIndexDidChange(body);
}

- (void)carousel:(RCTiCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    NSString *title = @"";
    
    id item = carousel.items[index];
    if ([item isKindOfClass:[RCTCardView class]] && [item title]) {
        title = [carousel.items[index] title];
    } else {
        RCTLogInfo(@"🔴 方法：%s，所在行：%zd，描述：无法识别的卡片控件或者没有设置标题", __FUNCTION__, __LINE__);
    }
    
    NSDictionary *body = @{
                           @"target" : carousel.reactTag,
                           @"title" : title,
                           @"index" : [NSNumber numberWithInteger:index]
                           };
    !carousel.onDidSelectItemAtIndex ?: carousel.onDidSelectItemAtIndex(body);
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    __block NSString *targetKey = nil;
    [iCarouselOptionConvertionFactory enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {  
        if ([obj isEqual:@(option)]) {
            targetKey = key;
            *stop = YES;
        }
    }];
    
    if (targetKey && [[self.optionValueConfigurations allKeys] containsObject:targetKey]) {
        return [self.optionValueConfigurations[targetKey] floatValue];
    }
    
    return value;
}

@end
