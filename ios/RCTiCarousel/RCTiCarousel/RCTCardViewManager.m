//
//  RCTCardViewManager.m
//  RCTiCarousel
//
//  Created by 张锋 on 06/12/2017.
//  Copyright © 2017 张锋. All rights reserved.
//

#import "RCTCardViewManager.h"
#import "RCTCardView.h"

@implementation RCTCardViewManager

RCT_EXPORT_MODULE();

- (UIView *)view {
    return [[RCTCardView alloc] initWithFrame:CGRectZero];
}

RCT_EXPORT_VIEW_PROPERTY(backgroundImageURL, NSString);
RCT_EXPORT_VIEW_PROPERTY(title, NSString);

@end
