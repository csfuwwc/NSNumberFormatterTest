//
//  NSString+More.h
//  NSNumberFormatterTest
//
//  Created by 李彦鹏 on 2017/12/7.
//  Copyright © 2017年 csfuwwc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString(More)

//转换为手机号格式  xxx xxxx xxxx
- (NSString *)phoneFormatter;

//转换为银行卡格式 xxxx xxxx xxxx xxxx xxx
- (NSString *)banCardFormatter;

@end
