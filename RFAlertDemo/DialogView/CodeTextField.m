//
//  CodeTextField.m
//  test
//
//  Created by 浅佳科技 on 2018/12/6.
//  Copyright © 2018年 sfk-JasonSu. All rights reserved.
//

#import "CodeTextField.h"

@implementation CodeTextField

/// 实现删除方法
- (void)deleteBackward
{
    [super deleteBackward];
    
    BOOL conform = [self.codeDelegate conformsToProtocol:@protocol(CodeTextFieldDelegate)];
    BOOL canResponse = [self.codeDelegate respondsToSelector:@selector(textFeildDeleteBackward:)];
    if (self.codeDelegate && conform && canResponse) {
        [self.codeDelegate textFeildDeleteBackward:self];
    }
}

-(void)setCodeDelegate:(id<CodeTextFieldDelegate>)codeDelegate{
    
    _codeDelegate = codeDelegate;
    self.delegate = codeDelegate;
}


-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    if (action == @selector(paste:))//禁止粘贴
        return NO;
    if (action == @selector(select:))// 禁止选择
        return NO;
    if (action == @selector(selectAll:))// 禁止全选
        return NO;
    return [super canPerformAction:action withSender:sender];
}

@end
