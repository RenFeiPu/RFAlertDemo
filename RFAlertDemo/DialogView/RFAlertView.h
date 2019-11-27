//
//  RFAlertView.h
//  InstrumentPro
//
//  Created by 浅佳科技 on 2019/1/23.
//  Copyright © 2019 KuaiZhunCheFu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RFAlertView : UIViewController

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle parentVC:(UIViewController*)parentVC completion:(void(^)(BOOL confirmed))completion;

@end

NS_ASSUME_NONNULL_END
