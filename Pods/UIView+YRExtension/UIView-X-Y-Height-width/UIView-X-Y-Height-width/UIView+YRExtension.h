//
//  UIView+fram.h
//  ChatListTest
//
//  Created by Luck on 16/7/15.
//  Copyright © 2016年 hongmw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YRExtension)

@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;
@property (nonatomic,assign)CGFloat centerX;
@property (nonatomic,assign)CGFloat centerY;
@property (nonatomic,assign)CGSize  size;
@property (nonatomic,assign)CGPoint origin;
@property (nonatomic,assign)CGFloat Height;
@property (nonatomic,assign)CGFloat Width;
@property (nonatomic,readonly,assign)CGFloat bootom;
@property (nonatomic,readonly,assign)CGFloat right;

@end
