# NSNumberFormatterTest
手机号、银行卡、输入/展示

###模式一：输入时格式控制

![image](https://github.com/csfuwwc/NSNumberFormatterTest/blob/master/NSNumberFormatterTest/demo.gif)


例如：
    self.inputTextField.style = UIInputTextFieldStyle_BankCard;

typedef enum : NSUInteger {
    
    UIInputTextFieldStyle_None = 0,//无格式限制
    
    UIInputTextFieldStyle_Phone = 1, //手机号
    
    UIInputTextFieldStyle_BankCard = 2, //银行卡
    
} UIInputTextFieldStyle;



###模式二：展示时格式控制

例如：
    self.resultLab.text = [self.normalTextField.text phoneFormatter];

//转换为手机号格式  xxx xxxx xxxx
- (NSString *)phoneFormatter;

//转换为银行卡格式 xxxx xxxx xxxx xxxx xxx
- (NSString *)banCardFormatter;

