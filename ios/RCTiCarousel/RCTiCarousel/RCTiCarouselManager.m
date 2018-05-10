//
//  RCTiCarouselManager.m
//  RNiCarousel
//
//  Created by 张锋 on 05/12/2017.
//  Copyright © 2017 张锋. All rights reserved.
//

#import "RCTiCarouselManager.h"
#import "RCTiCarousel.h"
#if __has_include(<React/RCTUIManager.h>)
#import <React/RCTUIManager.h>
#else
#import "RCTUIManager.h"
#endif

@implementation RCTiCarouselManager
    
RCT_EXPORT_MODULE();

- (UIView *)view {
    RCTiCarousel *iCarousel = [[RCTiCarousel alloc] initWithFrame:CGRectZero];
    return iCarousel;
}
    
- (NSDictionary *)constantsToExport {
    return @{
             @"Type" : @{
                     @"Linear" : @(iCarouselTypeLinear),
                     @"Rotary" : @(iCarouselTypeRotary),
                     @"InvertedRotary" : @(iCarouselTypeInvertedRotary),
                     @"Cylinder" : @(iCarouselTypeCylinder),
                     @"InvertedCylinder" : @(iCarouselTypeInvertedCylinder),
                     @"Wheel" : @(iCarouselTypeWheel),
                     @"InvertedWheel" : @(iCarouselTypeInvertedWheel),
                     @"CoverFlow" : @(iCarouselTypeCoverFlow),
                     @"CoverFlow2" : @(iCarouselTypeCoverFlow2),
                     @"TimeMachine" : @(iCarouselTypeTimeMachine),
                     @"InvertedTimeMachine" : @(iCarouselTypeInvertedTimeMachine),
                     @"Custom" : @(iCarouselTypeCustom)
                     }
             };
}

RCT_EXPORT_VIEW_PROPERTY(items, NSArray);
RCT_EXPORT_VIEW_PROPERTY(optionValueConfigurations, NSDictionary);

RCT_CUSTOM_VIEW_PROPERTY(type, iCarouselType, RCTiCarousel) {
    [view setType:[RCTConvert NSInteger:json]];
}
RCT_CUSTOM_VIEW_PROPERTY(bounces, BOOL, RCTiCarousel) {
    [view setType:[RCTConvert BOOL:json]];
}

/// Handler Event

RCT_EXPORT_VIEW_PROPERTY(onDidSelectItemAtIndex, RCTBubblingEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onCurrentItemIndexDidChange, RCTBubblingEventBlock);

/// Methods

RCT_EXPORT_METHOD(shouldScrollByOffsetDuration:(nonnull NSNumber *)reactTag offset:(CGFloat)offset duration:(CGFloat)duration) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,RCTiCarousel *> *viewRegistry) {
        RCTiCarousel *view = viewRegistry[reactTag];
        if ([view isKindOfClass:[RCTiCarousel class]]) {
            [view scrollByOffset:offset duration:duration];
        } else {
            RCTLogError(@"Invalid view returned from registry, expecting RCTiCarousel, got: %@", view);
        }
    }];
}
    
RCT_EXPORT_METHOD(shouldScrollToOffsetDuration:(nonnull NSNumber *)reactTag offset:(CGFloat)offset duration:(CGFloat)duration) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,RCTiCarousel *> *viewRegistry) {
        RCTiCarousel *view = viewRegistry[reactTag];
        if ([view isKindOfClass:[RCTiCarousel class]]) {
                [view scrollToOffset:offset duration:duration];
        } else {
            RCTLogError(@"Invalid view returned from registry, expecting RCTiCarousel, got: %@", view);
        }
    }];
}
    
RCT_EXPORT_METHOD(shouldScrollByNumberOfItemsDuration:(nonnull NSNumber *)reactTag items:(NSInteger)itemCount duration:(CGFloat)duration) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,RCTiCarousel *> *viewRegistry) {
        RCTiCarousel *view = viewRegistry[reactTag];
        if ([view isKindOfClass:[RCTiCarousel class]]) {
            [view scrollByNumberOfItems:itemCount duration:duration];
        } else {
            RCTLogError(@"Invalid view returned from registry, expecting RCTiCarousel, got: %@", view);
        }
    }];
}
    
RCT_EXPORT_METHOD(shouldScrollToItemAtIndexDuration:(nonnull NSNumber *)reactTag index:(NSInteger)index duration:(CGFloat)duration) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,RCTiCarousel *> *viewRegistry) {
        RCTiCarousel *view = viewRegistry[reactTag];
        if ([view isKindOfClass:[RCTiCarousel class]]) {
            [view scrollToItemAtIndex:index duration:duration];
        } else {
            RCTLogError(@"Invalid view returned from registry, expecting RCTiCarousel, got: %@", view);
        }
    }];
}
    
RCT_EXPORT_METHOD(shuoldScrollToItemAtIndexAnimated:(nonnull NSNumber *)reactTag index:(NSInteger)index animated:(BOOL)animated) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,RCTiCarousel *> *viewRegistry) {
        RCTiCarousel *view = viewRegistry[reactTag];
        if ([view isKindOfClass:[RCTiCarousel class]]) {
            [view scrollToItemAtIndex:index animated:animated];
        } else {
            RCTLogError(@"Invalid view returned from registry, expecting RCTiCarousel, got: %@", view);
        }
    }];
}
    
RCT_EXPORT_METHOD(fetchItemViewAtIndexHandler:(nonnull NSNumber *)reactTag index:(NSInteger)index resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,RCTiCarousel *> *viewRegistry) {
        RCTiCarousel *view = viewRegistry[reactTag];
        if ([view isKindOfClass:[RCTiCarousel class]]) {
            UIView *target = [view itemViewAtIndex:index];
            if (target) {
                resolve(target);
            } else {
                reject(@"-1", @"🔴 View could NOT be found.", nil);
            }
        } else {
            RCTLogError(@"Invalid view returned from registry, expecting RCTiCarousel, got: %@", view);
        }
    }];
}
    
RCT_EXPORT_METHOD(fetchIndexOfItemViewCallback:(nonnull NSNumber *)reactTag view:(UIView *)view callback:(RCTResponseSenderBlock)callback) {
	[self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,RCTiCarousel *> *viewRegistry) {
        RCTiCarousel *view = viewRegistry[reactTag];
        if ([view isKindOfClass:[RCTiCarousel class]]) {
            NSInteger index = [view indexOfItemView:view];
            callback(@[[NSNull null], @[@(index)]]);
        } else {
            RCTLogError(@"Invalid view returned from registry, expecting RCTiCarousel, got: %@", view);
        }
    }];
}
    
RCT_EXPORT_METHOD(fetchIndexOfItemViewOrSubviewCallback:(nonnull NSNumber *)reactTag view:(UIView *)view callback:(RCTResponseSenderBlock)callback) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,RCTiCarousel *> *viewRegistry) {
        RCTiCarousel *view = viewRegistry[reactTag];
        if ([view isKindOfClass:[RCTiCarousel class]]) {
            NSInteger index = [view indexOfItemViewOrSubview:view];
            callback(@[[NSNull null], @[@(index)]]);
        } else {
            RCTLogError(@"Invalid view returned from registry, expecting RCTiCarousel, got: %@", view);
        }
    }];
}
    
RCT_EXPORT_METHOD(fetchOffsetForItemAtIndexCallback:(nonnull NSNumber *)reactTag index:(NSInteger)index callback:(RCTResponseSenderBlock)callback) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,RCTiCarousel *> *viewRegistry) {
        RCTiCarousel *view = viewRegistry[reactTag];
        if ([view isKindOfClass:[RCTiCarousel class]]) {
            CGFloat offset = [view offsetForItemAtIndex:index];
            callback(@[[NSNull null], @[@(offset)]]);
        } else {
            RCTLogError(@"Invalid view returned from registry, expecting RCTiCarousel, got: %@", view);
        }
    }];
}
    
RCT_EXPORT_METHOD(fetchItemViewAtPointHandler:(nonnull NSNumber *)reactTag point:(CGPoint)point resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    //FXIME:此处接收到的`point`是个字典类型，要处理
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,RCTiCarousel *> *viewRegistry) {
        RCTiCarousel *view = viewRegistry[reactTag];
        if ([view isKindOfClass:[RCTiCarousel class]]) {
            UIView *target = [view itemViewAtPoint:point];
            if (target) {
                resolve(target);
            } else {
                reject(@"-1", @"🔴 View could NOT be found.", nil);
            }
        } else {
            RCTLogError(@"Invalid view returned from registry, expecting RCTiCarousel, got: %@", view);
        }
    }];
}
    
RCT_EXPORT_METHOD(shouldRemoveItemAtIndexAnimated:(nonnull NSNumber *)reactTag index:(NSInteger)index animated:(BOOL)animated) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,RCTiCarousel *> *viewRegistry) {
        RCTiCarousel *view = viewRegistry[reactTag];
        if ([view isKindOfClass:[RCTiCarousel class]]) {
            [view removeItemAtIndex:index animated:animated];
        } else {
            RCTLogError(@"Invalid view returned from registry, expecting RCTiCarousel, got: %@", view);
        }
    }];
}
    
RCT_EXPORT_METHOD(shouldInsertItemAtIndexAnimated:(nonnull NSNumber *)reactTag index:(NSInteger)index animated:(BOOL)animated) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,RCTiCarousel *> *viewRegistry) {
        RCTiCarousel *view = viewRegistry[reactTag];
        if ([view isKindOfClass:[RCTiCarousel class]]) {
            [view insertItemAtIndex:index animated:animated];
        } else {
            RCTLogError(@"Invalid view returned from registry, expecting RCTiCarousel, got: %@", view);
        }
    }];
}
    
RCT_EXPORT_METHOD(shouldReloadItemAtIndexAnimated:(nonnull NSNumber *)reactTag index:(NSInteger)index animated:(BOOL)animated) {
    [self.bridge.uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *,RCTiCarousel *> *viewRegistry) {
        RCTiCarousel *view = viewRegistry[reactTag];
        if ([view isKindOfClass:[RCTiCarousel class]]) {
            [view reloadItemAtIndex:index animated:animated];
        } else {
            RCTLogError(@"Invalid view returned from registry, expecting RCTiCarousel, got: %@", view);
        }
    }];
}

@end
