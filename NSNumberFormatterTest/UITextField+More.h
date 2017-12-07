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
    
    UIInputTextFieldStyle_Phone = 1, //手机号
    
    UIInputTextFieldStyle_BankCard = 2, //银行卡
    
} UIInputTextFieldStyle;

@interface UITextField (More)<UITextFieldDelegate>



@property (assign, nonatomic)UIInputTextFieldStyle style;


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
