//
//  UITextField+More.m
//  NSNumberFormatterTest
//
//  Created by 李彦鹏 on 2017/12/7.
//  Copyright © 2017年 csfuwwc. All rights reserved.
//

#import "UITextField+More.h"
#import <objc/runtime.h>

@implementation UITextField (More)


//设置最大输入位数
#pragma mark - UITextFieldInputLength

static const char * TextFieldMaxInputLengthKey = "TextFieldMaxInputLengthKey";

- (void)setMaxInputLength:(NSInteger)maxInputLength
{
    objc_setAssociatedObject(self, TextFieldMaxInputLengthKey, @(maxInputLength), OBJC_ASSOCIATION_ASSIGN);
    
    self.delegate = self;
}

- (NSInteger)maxInputLength
{
    return [objc_getAssociatedObject(self, TextFieldMaxInputLengthKey) integerValue];
}

//设置输入字符格式
#pragma mark - UITextFieldInputSytle

static const char * TextFieldStyleKey = "TextFieldStyleKey";

- (void)setStyle:(UIInputTextFieldStyle)style
{
    objc_setAssociatedObject(self, TextFieldStyleKey, @(style), OBJC_ASSOCIATION_ASSIGN);
    
    
    switch (style)
    {
        case UIInputTextFieldStyle_Phone:
        {
            //手机号码最多11位
            self.maxInputLength = 11;
            
            //检测输入-格式化
            [self formatterInputString];
        }
            break;
        case UIInputTextFieldStyle_BankCard:
        {
            //银行卡号最多19位 <longlong最大表示-9223372036854775807>
            self.maxInputLength = 19;
            
            //检测输入-格式化
            [self formatterInputString];
        }
            break;
            
        default:
        {
            //默认不限制位数
            self.maxInputLength = MAXFLOAT;
        }
            break;
    }
    

}

- (UIInputTextFieldStyle)style
{
    return [objc_getAssociatedObject(self, TextFieldStyleKey) integerValue];
}


//格式化输入字符
- (void)formatterInputString
{
    [self handleControlEvent:UIControlEventEditingChanged withBlock:^(UITextField *tf) {
       
        //去空
        NSString * string = [tf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if ([string length]==0)
        {
            return;
        }
        
        NSDecimalNumber * number = [NSDecimalNumber decimalNumberWithString:string];

        //获取格式化后的字符
        tf.text  = [[self formatterWithString:string] stringFromNumber:number];
        
        
    }];
}

- (NSNumberFormatter *)formatterWithString:(NSString *)string
{
    NSNumberFormatter * formatter = [NSNumberFormatter new];
    
    //设置分隔符
    [formatter setGroupingSeparator:@" "];
    //设置使用组分割
    formatter.usesGroupingSeparator = YES;
    
    switch (self.style)
    {
        case UIInputTextFieldStyle_Phone:
        {
            //设置首个组长度<从右向左>
            formatter.groupingSize = ([string length]-3)%4>0?([string length]-3)%4:4;
            //设置第二个组长度
            formatter.secondaryGroupingSize = [string length]>7?4:3;
        }
            break;
        case UIInputTextFieldStyle_BankCard:
        {
            
            //设置首个组长度<从右向左>
            formatter.groupingSize = ([string length]-4)%4>0?([string length]-4)%4:4;
            //设置第二个组长度
            formatter.secondaryGroupingSize = 4;
        }
            break;
            
        default:
            break;
    }
    
    return formatter;
}


#pragma mark - UIControlEventBlock

static const char * TextFieldMoreKey = "TextFieldMoreKey";

-(void)handleControlEvent:(UIControlEvents)event withBlock:(EditBlock)block
{
    objc_setAssociatedObject(self, TextFieldMoreKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(editEvent:) forControlEvents:event];
}
-(void)endEditBlock:(EditBlock)block
{
    objc_setAssociatedObject(self, &TextFieldMoreKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(editEvent:) forControlEvents:UIControlEventEditingDidEnd];
}

-(void)editEvent:(UITextField *)textField
{
    EditBlock block = objc_getAssociatedObject(self, TextFieldMoreKey);
    
    if (block)
    {
        block(textField);
    }
}



#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (![string isEqualToString:@""])
    {
        
        NSString * currentString = self.style!=UIInputTextFieldStyle_None?[textField.text stringByReplacingOccurrencesOfString:@" " withString:@""]:textField.text;

        if ([currentString length]>= self.maxInputLength)
        {
            return NO;
        }
    }
    
    return YES;
}

//最终字符
- (NSString *)resultString
{
    if (self.style != UIInputTextFieldStyle_None)
    {
        return [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    return self.text;
}


@end
