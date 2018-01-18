//
//  ViewController.m
//  NSNumberFormatterTest
//
//  Created by 李彦鹏 on 2017/12/7.
//  Copyright © 2017年 csfuwwc. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+More.h"
#import "NSString+More.h"

@interface ViewController ()

//输入字符格式控制-输入框
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

//输入字符格式不控制-输入框
@property (weak, nonatomic) IBOutlet UITextField *normalTextField;
//输入字符格式不控制-结果展示lab
@property (weak, nonatomic) IBOutlet UILabel *resultLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //为textfield设置对应style即可实现 格式化输入字符-格式化
    self.inputTextField.style = UIInputTextFieldStyle_BankCard;
        
}

- (IBAction)fonish:(id)sender
{
    [self.normalTextField resignFirstResponder];
    
    self.resultLab.text = [self.normalTextField.text phoneFormatter];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
