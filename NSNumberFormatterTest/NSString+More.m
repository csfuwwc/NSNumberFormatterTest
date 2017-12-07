//
//  NSString+More.m
//  NSNumberFormatterTest
//
//  Created by 李彦鹏 on 2017/12/7.
//  Copyright © 2017年 csfuwwc. All rights reserved.
//

#import "NSString+More.h"

@implementation NSString(More)

- (NSString *)PhoneFormatter
{
    NSNumber * number = [NSNumber numberWithInteger:[self integerValue]];
    
    NSNumberFormatter * formatter = [NSNumberFormatter new];
    
    //设置分隔符
    [formatter setGroupingSeparator:@" "];
    //设置分割格式
    formatter.positiveFormat = @"###,###0";
    
    
    return [formatter stringFromNumber:number];
    
}

@end
