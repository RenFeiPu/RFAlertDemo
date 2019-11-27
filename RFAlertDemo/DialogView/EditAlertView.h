//
//  EditAlertView.h
//  RFAlertDemo
//
//  Created by 浅佳科技 on 2019/2/14.
//  Copyright © 2019 浅佳科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EditAlertView : UIViewController

+(void)showInputViewWithParentVC:(UIViewController *)parentVC remarkBlock:(void(^)(NSString *remark))remarkBlock;

@end

NS_ASSUME_NONNULL_END
