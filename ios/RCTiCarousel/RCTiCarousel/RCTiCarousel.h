//
//  RCTiCarousel.h
//  RNiCarousel
//
//  Created by 张锋 on 05/12/2017.
//  Copyright © 2017 张锋. All rights reserved.
//

#if __has_include(<iCarousel/iCarousel.h>)
#import <iCarousel/iCarousel.h>
#else
#import "iCarousel.h"
#endif
#if __has_include(<React/RCTComponent.h>)
#import <React/RCTComponent.h>
#else
#import "RCTComponent.h"
#endif

@interface RCTiCarousel : iCarousel <iCarouselDataSource, iCarouselDelegate>

/**
 可以使用这个方式初始化，但是不推荐
 */
@property (nonatomic, strong) NSMutableArray *items;

/**
 option配置字典，参考`+(void)Load`方法
 */
@property (nonatomic, strong) NSDictionary *optionValueConfigurations;

/// 交互事件

@property (nonatomic, copy) RCTBubblingEventBlock onDidSelectItemAtIndex;
@property (nonatomic, copy) RCTBubblingEventBlock onCurrentItemIndexDidChange;

@end
