//
//  QJSLMiddleView.m
//  Lawyer
//
//  Created by MYMAc on 2017/7/28.
//  Copyright © 2017年 ShangYu. All rights reserved.
//

#import "QJSLMiddleView.h"

@implementation QJSLMiddleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    [super awakeFromNib];

    _TextView.delegate = self;
    _TextView.placeholderText = @"请输入合同用途（不少于30字）";
    
    _TextView.returnKeyType = UIReturnKeyDone;
    _PhoneField.returnKeyType = UIReturnKeyDone;
    _EmailField.returnKeyType = UIReturnKeyDone;
    _PhoneField.delegate = self;
    _EmailField.delegate = self;
}

// 开始 输入
-(void)textViewDidBeginEditing:(UITextView *)textView{

//    if([textView.text isEqualToString:@"请输入合同用途（不少于30字）"]){
//            textView.text = @"";
//         textView.textColor = [UIColor colorWithHex:0x333333];
//    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    
//    if (textView.text.length == 0) {
//     textView.text = @"请输入合同用途（不少于30字）";
//         textView.textColor = [UIColor colorWithHex:0x999999];
//    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}
@end
