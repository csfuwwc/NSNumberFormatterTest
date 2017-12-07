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

#pragma mark - UITextFieldInputSytle

static const char * TextFieldStyleKey = "TextFieldStyleKey";

- (void)setStyle:(UIInputTextFieldStyle)style
{
    objc_setAssociatedObject(self, TextFieldStyleKey, @(style), OBJC_ASSOCIATION_ASSIGN);
    
    self.delegate  = self;
    
    //检测输入-格式化
    [self formatterInputString];
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
        
        NSNumber * number = [NSNumber numberWithInteger:[string integerValue]];
        NSNumberFormatter * formatter = [NSNumberFormatter new];
        
        //设置分隔符
        [formatter setGroupingSeparator:@" "];
        //设置使用组分割
        formatter.usesGroupingSeparator = YES;
        
        //设置首个组长度<从右向左>
        formatter.groupingSize = ([string length]-3)%4>0?([string length]-3)%4:4;
        //设置第二个组长度
        formatter.secondaryGroupingSize = [string length]>7?4:3;
        
        //获取格式化后的字符
        tf.text  = [formatter stringFromNumber:number];
        
        
    }];
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
    if (self.style != 0 && ![string isEqualToString:@""])
    {
        
        NSString * string = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];

        
        switch (self.style)
        {
            case UIInputTextFieldStyle_Phone:
            {
                if ([string length]>= 11)
                {
                    return NO;
                }
            }
                break;
             case UIInputTextFieldStyle_BankCard:
            {
                if ([string length]>= 16)
                {
                    return NO;
                }
            }
                break;
            default:
                break;
        }
    }
    

    
    return YES;
}


@end
