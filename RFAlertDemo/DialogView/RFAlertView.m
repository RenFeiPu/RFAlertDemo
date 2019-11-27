//
//  RFAlertView.m
//  InstrumentPro
//
//  Created by 浅佳科技 on 2019/1/23.
//  Copyright © 2019 KuaiZhunCheFu. All rights reserved.
//

#import "RFAlertView.h"
#import "UIColor+ColorHexadecimal.h"
#import <ReactiveObjC.h>
#import <Masonry.h>

@interface RFAlertView ()

@property (strong) UIView *backView;
@property (strong) UIView *lineView;
@property (strong) UIView *verticalLine;
@property (strong) UIButton *confirmBtn;
@property (strong) UIButton *cancleBtn;
@property (strong) UILabel *titleLabel;
@property (strong) UILabel *messageLabel;

@end

@implementation RFAlertView

#define FORMATSTRING(String) [NSString stringWithFormat:@"%@",String]
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
}

+(void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle parentVC:(UIViewController *)parentVC completion:(void (^)(BOOL))completion{
    
    RFAlertView *alertView = [[RFAlertView alloc]init];
    alertView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    alertView.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [alertView alertWithTitle:title message:message cancelTitle:cancelTitle okTitle:okTitle completion:completion];
    [parentVC presentViewController:alertView animated:YES completion:nil];
}

-(void)alertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle completion:(void (^)(BOOL confirmed))completion{
    
    [self createUI];
    [self setViewConstraintsWithTitle:title message:message cancelTitle:cancelTitle okTitle:okTitle];
//    点击
    __weak typeof(self)weakSelf = self;
    [[_cancleBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf dismiss];
        completion(NO);
    }];
    
    [[_confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf dismiss];
        completion(YES);
    }];
}

-(void)createUI{
    
//    背景
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 4;
    _backView.layer.masksToBounds = YES;
    [self.view addSubview:_backView];
    
//    分割线
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor colorWithHexString:@"#D8D8D8"];
    [_backView addSubview:_lineView];
    
//    确认
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setTitleColor:[UIColor colorWithHexString:@"#FF6666"] forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_backView addSubview:_confirmBtn];
    
//    取消
    _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancleBtn setTitleColor:[UIColor colorWithHexString:@"#B6B6B6"] forState:UIControlStateNormal];
    _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_backView addSubview:_cancleBtn];
    
//    分割线
    _verticalLine = [[UIView alloc]init];
    _verticalLine.backgroundColor = [UIColor colorWithHexString:@"#D8D8D8"];
    [_backView addSubview:_verticalLine];
//    标题
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor colorWithHexString:@"#5E5E5E"];
    [_backView addSubview:_titleLabel];
//    内容
    _messageLabel = [[UILabel alloc]init];
    _messageLabel.font = [UIFont systemFontOfSize:16];
    _messageLabel.textColor = [UIColor colorWithHexString:@"#5E5E5E"];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.numberOfLines = 0;
    [_backView addSubview:_messageLabel];
}

-(void)setViewConstraintsWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle okTitle:(NSString *)okTitle{
    
    __weak typeof(self)weakSelf = self;
    CGFloat msgHeight = [self heightOflabelWithWidth:CGRectGetWidth(self.view.frame)-80 fontSize:16 Content:message];
    if ([FORMATSTRING(title) length]>0) {
        msgHeight = msgHeight+20;
    }
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view.mas_left).offset(40);
        make.right.mas_equalTo(weakSelf.view.mas_right).offset(-40);
        make.top.mas_equalTo(weakSelf.view.mas_top).offset((CGRectGetHeight(weakSelf.view.frame)-100-msgHeight)/2-30);
        make.height.mas_equalTo(100+msgHeight);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.backView.mas_left).offset(0);
        make.right.mas_equalTo(weakSelf.backView.mas_right).offset(0);
        make.bottom.mas_equalTo(weakSelf.backView.mas_bottom).offset(-45);
        make.height.mas_equalTo(0.5);
    }];
    
    if ([FORMATSTRING(okTitle) length]==0 || [FORMATSTRING(cancelTitle) length]==0) {
        [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.backView.mas_left).offset(0);
            make.right.mas_equalTo(weakSelf.backView.mas_right).offset(0);
            make.top.mas_equalTo(weakSelf.lineView.mas_bottom).offset(0);
            make.bottom.mas_equalTo(weakSelf.backView.mas_bottom).offset(0);
        }];
        if ([FORMATSTRING(okTitle) length]>0) {
            [weakSelf.confirmBtn setTitle:okTitle forState:UIControlStateNormal];
        }else{
            [weakSelf.confirmBtn setTitle:cancelTitle forState:UIControlStateNormal];
        }
    }else{
        [_verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.lineView.mas_bottom).offset(0);
            make.bottom.mas_equalTo(weakSelf.backView.mas_bottom).offset(0);
            make.width.mas_equalTo(0.5);
            make.centerX.mas_equalTo(weakSelf.backView.mas_centerX).offset(0);
        }];
        
        [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.backView.mas_left).offset(0);
            make.right.mas_equalTo(weakSelf.verticalLine.mas_left).offset(0);
            make.top.mas_equalTo(weakSelf.lineView.mas_bottom).offset(0);
            make.bottom.mas_equalTo(weakSelf.backView.mas_bottom).offset(0);
        }];
        [weakSelf.cancleBtn setTitle:cancelTitle forState:UIControlStateNormal];
        
        [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.verticalLine.mas_right).offset(0);
            make.right.mas_equalTo(weakSelf.backView.mas_right).offset(0);
            make.top.mas_equalTo(weakSelf.lineView.mas_bottom).offset(0);
            make.bottom.mas_equalTo(weakSelf.backView.mas_bottom).offset(0);
        }];
        [weakSelf.confirmBtn setTitle:okTitle forState:UIControlStateNormal];
    }

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.backView.mas_top).offset(20);
        make.left.mas_equalTo(weakSelf.backView.mas_left).offset(20);
        make.right.mas_equalTo(weakSelf.backView.mas_right).offset(-20);
    }];
    
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([FORMATSTRING(title) length]>0) {
            make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(0);
        }else{
            make.top.mas_equalTo(weakSelf.backView.mas_top).offset(10);
        }
        make.left.mas_equalTo(weakSelf.backView.mas_left).offset(20);
        make.right.mas_equalTo(weakSelf.backView.mas_right).offset(-20);
        make.bottom.mas_equalTo(weakSelf.lineView.mas_top).offset(-5);
    }];
    _titleLabel.text = title;
    _messageLabel.text = message;
    
}

//计算文字高度
-(CGFloat)heightOflabelWithWidth:(CGFloat)width fontSize:(CGFloat)fontSize Content:(nonnull NSString *)content{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = 0;
    label.text = content;
    [label sizeToFit];
    return label.frame.size.height;
}

-(void)dismiss{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
