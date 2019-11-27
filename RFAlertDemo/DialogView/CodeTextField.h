//
//  CodeTextField.h
//  test
//
//  Created by 浅佳科技 on 2018/12/6.
//  Copyright © 2018年 sfk-JasonSu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CodeTextFieldDelegate<UITextFieldDelegate>

@optional

- (void)textFeildDeleteBackward:(UITextField *)textField;

@end

@interface CodeTextField : UITextField

@property (nonatomic, weak) id <CodeTextFieldDelegate> codeDelegate;

@end
