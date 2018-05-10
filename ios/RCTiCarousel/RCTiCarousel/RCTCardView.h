//
//  RCTCardView.h
//  RCTiCarousel
//
//  Created by 张锋 on 06/12/2017.
//  Copyright © 2017 张锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCTCardView : UIView

/**
 卡片背景图片URL地址
 */
@property (nonatomic, copy) NSString *backgroundImageURL;

/**
 卡片标题
 */
@property (nonatomic, copy) NSString *title;

@end
