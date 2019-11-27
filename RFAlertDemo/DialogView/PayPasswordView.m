//
//  PayPasswordView.m
//  test
//
//  Created by 浅佳科技 on 2018/12/6.
//  Copyright © 2018年 浅佳科技. All rights reserved.
//

#import "PayPasswordView.h"
#import "CodeTextField.h"
#import "CodeLabel.h"
#import <ReactiveObjC.h>

const CGFloat itemWidth = 40;//宽度
const CGFloat space = 10;//间距
const CGFloat originY = 400;//高度位置
const CGFloat viewHeight = 150;//密码框背景高度

@interface PayPasswordView ()<CodeTextFieldDelegate>

@property (strong ,nonatomic) CodeLabel *label1;
@property (strong ,nonatomic) CodeLabel *label2;
@property (strong ,nonatomic) CodeLabel *label3;
@property (strong ,nonatomic) CodeLabel *label4;
@property (strong ,nonatomic) CodeLabel *label5;
@property (strong ,nonatomic) CodeLabel *label6;
@property (strong ,nonatomic) CodeTextField *textField;
@property (copy ,nonatomic) void (^PayPasswordBlock)(NSString *password);

@end

@implementation PayPasswordView

+(void)showInputViewWithParentVC:(UIViewController *)parentVC passwordBlock:(void (^)(NSString * _Nonnull))passwordBlock{
    
    PayPasswordView *passwordView = [[PayPasswordView alloc]init];
    passwordView.modalPresentationStyle = UIModalPresentationOverFullScreen;
    passwordView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    passwordView.payPasswordBlock = passwordBlock;
    [parentVC presentViewController:passwordView animated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self setSubViews];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

-(void)setSubViews{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, originY, CGRectGetWidth(self.view.frame), viewHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.userInteractionEnabled = YES;
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    backView.tag = 100;
    [self.view addSubview:backView];
    
    CGFloat originX = (CGRectGetWidth(self.view.frame)-itemWidth*6-space*5)/2;
    for (NSInteger i=0; i<6; i++) {
        CodeLabel *label = [[CodeLabel alloc]initWithFrame:CGRectMake(originX+(itemWidth+space)*i, (viewHeight-itemWidth)/2, itemWidth, itemWidth)];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.layer.cornerRadius = 5;
        label.layer.masksToBounds = YES;
        [self bolderColor:[UIColor grayColor] view:label];
        if (i==0) {
            self.label1 = label;
        }else if (i==1){
            self.label2 = label;
        }else if (i==2){
            self.label3 = label;
        }else if (i==3){
            self.label4 = label;
        }else if (i==4){
            self.label5 = label;
        }else if (i==5){
            self.label6 = label;
        }
        [backView addSubview:label];
    }
    self.textField = [[CodeTextField alloc]initWithFrame:self.label1.frame];
    self.textField.secureTextEntry = YES;
    self.textField.textAlignment = NSTextAlignmentCenter;
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.codeDelegate = self;
    [self bolderColor:[UIColor blueColor] view:self.textField];
    __weak typeof(self)weakSelf = self;
    [self.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        CGFloat originX = weakSelf.textField.frame.origin.x;
        NSString *string = [x stringByReplacingOccurrencesOfString:@" " withString:@""];
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (string.length==1) {//长度为1
            if (originX==CGRectGetMinX(weakSelf.label1.frame)) {
                weakSelf.label1.plaintext = string;
                weakSelf.label1.text = @"*";
                [self bolderColor:[UIColor blueColor] view:self.label1];
                weakSelf.textField.frame = weakSelf.label2.frame;
            }else if (originX==CGRectGetMinX(weakSelf.label2.frame)) {
                weakSelf.label2.text = @"*";
                weakSelf.label2.plaintext = string;
                [self bolderColor:[UIColor blueColor] view:self.label2];
                weakSelf.textField.frame = weakSelf.label3.frame;
            }else if (originX==CGRectGetMinX(weakSelf.label3.frame)) {
                weakSelf.label3.text = @"*";
                weakSelf.label3.plaintext = string;
                [self bolderColor:[UIColor blueColor] view:self.label3];
                weakSelf.textField.frame = weakSelf.label4.frame;
            }else if (originX==CGRectGetMinX(weakSelf.label4.frame)) {
                weakSelf.label4.text = @"*";
                weakSelf.label4.plaintext = string;
                [self bolderColor:[UIColor blueColor] view:self.label4];
                weakSelf.textField.frame = weakSelf.label5.frame;
            }else if (originX==CGRectGetMinX(weakSelf.label5.frame)) {
                weakSelf.label5.text = @"*";
                weakSelf.label5.plaintext = string;
                [self bolderColor:[UIColor blueColor] view:self.label5];
                weakSelf.textField.frame = weakSelf.label6.frame;
            }else if (originX==CGRectGetMinX(weakSelf.label6.frame)) {
                weakSelf.label6.text = @"*";
                weakSelf.label6.plaintext = string;
                [self bolderColor:[UIColor blueColor] view:self.label6];
                weakSelf.textField.frame = weakSelf.label6.frame;
            }
        }
        weakSelf.textField.text = @"";
    }];
    [backView addSubview:self.textField];
}

-(void)textFeildDeleteBackward:(UITextField *)textField{
    
    CGFloat originX = self.textField.frame.origin.x;
    if (self.textField.text.length==0){//删除
        if (originX==CGRectGetMinX(self.label1.frame)) {
            self.label1.text = @"";
            self.label1.plaintext = @"";
            [self bolderColor:[UIColor grayColor] view:self.label1];
            self.textField.frame = self.label1.frame;
        }else if (originX==CGRectGetMinX(self.label2.frame)) {
            self.label1.text = @"";
            self.label1.plaintext = @"";
            [self bolderColor:[UIColor grayColor] view:self.label1];
            self.textField.frame = self.label1.frame;
        }else if (originX==CGRectGetMinX(self.label3.frame)) {
            self.label2.text = @"";
            self.label2.plaintext = @"";
            [self bolderColor:[UIColor grayColor] view:self.label2];
            self.textField.frame = self.label2.frame;
        }else if (originX==CGRectGetMinX(self.label4.frame)) {
            self.label3.text = @"";
            self.label3.plaintext = @"";
            [self bolderColor:[UIColor grayColor] view:self.label3];
            self.textField.frame = self.label3.frame;
        }else if (originX==CGRectGetMinX(self.label5.frame)) {
            self.label4.text = @"";
            self.label4.plaintext = @"";
            [self bolderColor:[UIColor grayColor] view:self.label4];
            self.textField.frame = self.label4.frame;
        }else if (originX==CGRectGetMinX(self.label6.frame)) {
            if (self.label6.text.length==0) {
                self.label5.text = @"";
                self.label5.plaintext = @"";
                [self bolderColor:[UIColor grayColor] view:self.label5];
                self.textField.frame = self.label5.frame;
            }else{
                self.label6.text = @"";
                self.label6.plaintext = @"";
                [self bolderColor:[UIColor grayColor] view:self.label6];
                self.textField.frame = self.label6.frame;
            }
        }
    }
}


-(void)bolderColor:(UIColor*)color view:(UIView*)view{
    
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = 0.5;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    if (self.label1.plaintext.length>0 && self.label2.plaintext.length>0 && self.label3.plaintext.length>0 && self.label4.plaintext>0 && self.label5.plaintext.length>0 && self.label6.plaintext.length>0) {
        NSString *password = [NSString stringWithFormat:@"%@%@%@%@%@%@",self.label1.plaintext,self.label2.plaintext,self.label3.plaintext,self.label4.plaintext,self.label5.plaintext,self.label6.plaintext];
        self.PayPasswordBlock(password);
        if (touch.view.tag!=100) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else{
        self.PayPasswordBlock(@"密码格式不正确");
    }
}

@end
