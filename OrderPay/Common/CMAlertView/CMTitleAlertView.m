//
//  CMAlertView.m
//  JYCashLoan
//
//  Created by leipeng on 2017/11/8.
//  Copyright © 2017年 jieyue. All rights reserved.
//

#import "CMTitleAlertView.h"
@interface CMTitleAlertView()

/**
 标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

/**
 取消按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *backView;

/**
 确定按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (nonatomic, copy) void (^completion)(NSInteger);


@end
@implementation CMTitleAlertView

+ (void)showWithTitle:(NSString *)aString completion:(void (^)(NSInteger))completion{
    CMTitleAlertView *alertView = [CMTitleAlertView alertView];
    alertView.cancelIndex = -1000;
    alertView.frame = [UIScreen mainScreen].bounds;
    alertView.titleLable.text = aString;
    alertView.completion = completion;
    [alertView show];
}

+(instancetype)alertView{
    return [[[NSBundle mainBundle] loadNibNamed:@"CMTitleAlertView" owner:nil options:nil] lastObject];
}
- (void)show{
    
    self.backView.alpha = 0;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.backView.alpha = 0.67;
    }];
}
- (void)dismiss{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        self.backView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)dealloc{
    NSLog(@"销毁");
}
- (IBAction)cancelButtonClick:(id)sender {
    [self dismiss];
    if (self.completion) {
        self.completion(self.cancelIndex);
    }
}
- (IBAction)confirmButtonClick:(id)sender {
    [self dismiss];
    if (self.completion) {
        self.completion(1);
    }
}
@end
