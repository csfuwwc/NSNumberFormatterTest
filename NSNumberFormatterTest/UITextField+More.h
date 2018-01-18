//
//  UITextField+More.h
//  NSNumberFormatterTest
//
//  Created by 李彦鹏 on 2017/12/7.
//  Copyright © 2017年 csfuwwc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditBlock)(UITextField * tf);

typedef enum : NSUInteger {
    
    UIInputTextFieldStyle_None = 0,//无格式限制
    
    UIInputTextFieldStyle_Phone = 1, //手机号
    
    UIInputTextFieldStyle_BankCard = 2, //银行卡
    
} UIInputTextFieldStyle;

@interface UITextField (More)<UITextFieldDelegate>


//格式-手机号/银行卡/金额等等
@property (assign, nonatomic)UIInputTextFieldStyle style;

//最大输入位数
@property (assign, nonatomic)NSInteger maxInputLength;

//最终字符
@property (assign, nonatomic)NSString * resultString;


/**
 *  输入框事件触发回调
 *
 *  @param event 事件
 *  @param block 回调
 */
- (void)handleControlEvent:(UIControlEvents)event withBlock:(EditBlock)block;
/**
 *  输入框完成输入触发回调
 *
 *  @param block 回调
 */
-(void)endEditBlock:(EditBlock)block;


@end
