//
//  EditAlertView.m
//  RFAlertDemo
//
//  Created by 浅佳科技 on 2019/2/14.
//  Copyright © 2019 浅佳科技. All rights reserved.
//

#import "EditAlertView.h"
#import "UIColor+ColorHexadecimal.h"
#import <ReactiveObjC.h>
#import <Masonry.h>

@interface EditAlertView ()<UITextViewDelegate>

@property (strong) UIView *backView;
@property (strong) UIView *lineView;
@property (strong) UIView *verticalLine;
@property (strong) UIButton *confirmBtn;
@property (strong) UIButton *cancleBtn;
@property (strong) UITextView *messageView;
@property (strong) UILabel *titleLabel;

@end
#define FORMATSTRING(String) [NSString stringWithFormat:@"%@",String]
static CGFloat const msgHeight = 160;
@implementation EditAlertView

+(void)showInputViewWithParentVC:(UIViewController *)parentVC remarkBlock:(void (^)(NSString * _Nonnull))remarkBlock{
    
    EditAlertView *editView = [[EditAlertView alloc]init];
    editView.modalPresentationStyle = UIModalPresentationOverFullScreen;
    editView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [editView showInputViewWithRemarkBlock:remarkBlock];
    [parentVC presentViewController:editView animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.messageView becomeFirstResponder];
}

-(void)showInputViewWithRemarkBlock:(void (^)(NSString * _Nonnull))remarkBlock{
    
    [self createUI];
    [self setViewConstraints];
    //    点击
    __weak typeof(self)weakSelf = self;
    [[_cancleBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf dismiss];
    }];
    
    [[_confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf.messageView resignFirstResponder];
        [weakSelf dismiss];
        remarkBlock(weakSelf.messageView.text);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
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
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_backView addSubview:_confirmBtn];
    
    //    取消
    _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancleBtn setTitleColor:[UIColor colorWithHexString:@"#B6B6B6"] forState:UIControlStateNormal];
    _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
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
    _titleLabel.text = @"备注";
    [_backView addSubview:_titleLabel];
    //    内容
    _messageView = [self textViewWithtextColor:[UIColor colorWithHexString:@"#5E5E5E"] placeHolder:@"请输入内容" font:15 placeHolderColor:[UIColor colorWithHexString:@"#CFCFCF"] superView:_backView];
    _messageView.delegate = self;
}

-(void)setViewConstraints{
    
    __weak typeof(self)weakSelf = self;
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view.mas_left).offset(40);
        make.right.mas_equalTo(weakSelf.view.mas_right).offset(-40);
        make.top.mas_equalTo(weakSelf.view.mas_top).offset((CGRectGetHeight(weakSelf.view.frame)-msgHeight)/2-30);
        make.height.mas_equalTo(msgHeight);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.backView.mas_left).offset(0);
        make.right.mas_equalTo(weakSelf.backView.mas_right).offset(0);
        make.bottom.mas_equalTo(weakSelf.backView.mas_bottom).offset(-45);
        make.height.mas_equalTo(0.5);
    }];
    
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
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.verticalLine.mas_right).offset(0);
        make.right.mas_equalTo(weakSelf.backView.mas_right).offset(0);
        make.top.mas_equalTo(weakSelf.lineView.mas_bottom).offset(0);
        make.bottom.mas_equalTo(weakSelf.backView.mas_bottom).offset(0);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.backView.mas_top).offset(20);
        make.left.mas_equalTo(weakSelf.backView.mas_left).offset(20);
        make.right.mas_equalTo(weakSelf.backView.mas_right).offset(-20);
    }];
    
    [_messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(weakSelf.backView.mas_left).offset(20);
        make.right.mas_equalTo(weakSelf.backView.mas_right).offset(-20);
        make.bottom.mas_equalTo(weakSelf.lineView.mas_top).offset(-5);
    }];
}

//监听UITextView内容并设置高度
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    CGFloat contentHeight = [self heightOflabelWithWidth:CGRectGetWidth(self.view.frame)-120 Content:textView.text];
    if (contentHeight>=52.0) {//当输入内容大于两行时增加输入框高度
        [_backView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(msgHeight+contentHeight-52);
        }];
//        更新布局
        [self.view layoutIfNeeded];
    }
    return YES;
}

//计算文字高度
-(CGFloat)heightOflabelWithWidth:(CGFloat)width Content:(nonnull NSString *)content{
    
    UITextView *label = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    label.font = [UIFont systemFontOfSize:15];
    label.text = content;
    [label sizeToFit];
    return label.frame.size.height;
}

//可换行的textfield
-(UITextView*)textViewWithtextColor:(UIColor*)textColor placeHolder:(NSString*)placeHolder font:(NSInteger)font placeHolderColor:(UIColor*)placeHolderColor superView:(UIView *)superView{
    
    UITextView *placeTextView = [[UITextView alloc]init];
    placeTextView.font = [UIFont systemFontOfSize:font];
    placeTextView.textColor = textColor;
    placeTextView.scrollEnabled = NO;
    UILabel *placeLabel = [[UILabel alloc]init];
    placeLabel.font = [UIFont systemFontOfSize:font];
    placeLabel.textColor = placeHolderColor;
    placeLabel.text = placeHolder;
    [placeLabel sizeToFit];
    [placeTextView addSubview:placeLabel];
    [placeTextView setValue:placeLabel forKey:@"_placeholderLabel"];
    [superView addSubview:placeTextView];
    return placeTextView;
}

-(void)dismiss{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
