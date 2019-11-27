//
//  ViewController.m
//  RFAlertDemo
//
//  Created by 浅佳科技 on 2019/2/14.
//  Copyright © 2019 浅佳科技. All rights reserved.
//

#import "ViewController.h"
#import "PayPasswordView.h"
#import "RFAlertView.h"
#import "EditAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)alertClick:(id)sender {
    
    [RFAlertView showAlertWithTitle:@"提示" message:@"这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试这是一个测试" cancelTitle:@"取消" okTitle:@"确认" parentVC:self completion:^(BOOL confirmed) {
        if (confirmed) {
            NSLog(@"选择了确认");
        }
    }];
}

- (IBAction)editAlertClick:(id)sender {
    
    [EditAlertView showInputViewWithParentVC:self remarkBlock:^(NSString * _Nonnull remark) {
        NSLog(@"%@",remark);
    }];
}

- (IBAction)codeClick:(id)sender {
    
    [PayPasswordView showInputViewWithParentVC:self passwordBlock:^(NSString * _Nonnull password) {
        NSLog(@"%@",password);
    }];
}


@end
