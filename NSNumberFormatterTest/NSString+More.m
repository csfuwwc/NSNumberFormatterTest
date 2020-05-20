//
//  NSString+More.m
//  NSNumberFormatterTest
//
//  Created by 李彦鹏 on 2017/12/7.
//  Copyright © 2017年 csfuwwc. All rights reserved.
//

#import "NSString+More.h"

@implementation NSString(More)

- (NSString *)phoneFormatter
{
    NSDecimalNumber * number = [NSDecimalNumber decimalNumberWithString:self];

    NSNumberFormatter * formatter = [NSNumberFormatter new];
    
    /*
    //设置分隔符
    [formatter setGroupingSeparator:@" "];
    //设置分割格式
    formatter.positiveFormat = @"###,###0";
    */
    
    //设置分隔符
    [formatter setGroupingSeparator:@" "];
    //设置使用组分割
    formatter.usesGroupingSeparator = YES;
    
    //设置首个组长度<从右向左>
    formatter.groupingSize = ([self length]-3)%4>0?([self length]-3)%4:4;
    //设置第二个组长度
    formatter.secondaryGroupingSize = [self length]>7?4:3;
    
    
    return [formatter stringFromNumber:number];
    
}

- (NSString *)banCardFormatter
{
    NSDecimalNumber * number = [NSDecimalNumber decimalNumberWithString:self];
    
    NSNumberFormatter * formatter = [NSNumberFormatter new];
    
    //设置分隔符
    [formatter setGroupingSeparator:@" "];
    //设置使用组分割
    formatter.usesGroupingSeparator = YES;
    
    //设置首个组长度<从右向左>
    formatter.groupingSize = ([self length]-4)%4>0?([self length]-4)%4:4;
    //设置第二个组长度
    formatter.secondaryGroupingSize = 4;
    
    //如果string以0开头
    if ([self hasPrefix:@"0"] && [number stringValue].length != self.length)
    {
        NSString *prefixStr = [self substringToIndex:[self length]-[number stringValue].length];
        
        
        NSMutableString *tempStr = [prefixStr mutableCopy];
                        
        for (NSInteger i = 4; i <= prefixStr.length; i += 4)
        {
            [tempStr insertString:@" " atIndex:(i+(i-1)/4)];
        }
                        
        formatter.positivePrefix = tempStr;
    }
    
    return [formatter stringFromNumber:number];
}

@end
