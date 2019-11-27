//
//  PayPasswordView.h
//  test
//
//  Created by 浅佳科技 on 2018/12/6.
//  Copyright © 2018年 浅佳科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayPasswordView : UIViewController

+(void)showInputViewWithParentVC:(UIViewController *)parentVC passwordBlock:(void(^)(NSString *password))passwordBlock;

@end

NS_ASSUME_NONNULL_END
