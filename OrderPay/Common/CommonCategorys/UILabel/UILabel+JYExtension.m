//
//  UILabel+JYExtension.m
//  JYFramework
//
//  Created by mcitosh on 2017/7/31.
//  Copyright © 2017年 mcitosh. All rights reserved.
//

#import "UILabel+JYExtension.h"

@implementation UILabel (JYExtension)

-(void)scrollDigitalFromIntNumber:(int)originalnumber toNewIntNumber:(int)newNumber
{
    self.text = [NSString stringWithFormat:@"%d",originalnumber];
    __block int timeout=100; //倒计时时间
    __block int currentNum = self.text.intValue;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),0.01*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        //计算每次递增
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.text = [NSString stringWithFormat:@"%d",newNumber];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (currentNum>=newNumber) {
                    timeout=0;
                }else{
                    currentNum = currentNum +1;
                    self.text = [NSString stringWithFormat:@"%d",currentNum];
                }
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

static dispatch_source_t currTimer;
-(void)scrollDigitalFromDoubleNumber:(double)originalnumber toNewDoubleNumber:(double)newNumber withType:(NSInteger)type
{
    self.text = [NSString stringWithFormat:@"%.2f",originalnumber];
    __block int timeout = 100; //倒计时时间
    __block double currentNum = self.text.intValue;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    currTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(currTimer,dispatch_walltime(NULL, 0),0.01*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(currTimer, ^{
        //计算每次递增
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(currTimer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                if (type == 1) {
                    self.text = [NSString stringWithFormat:@"%.2f", newNumber];
                }else{
                    self.text = [UILabel formatterNumberWithComma:[NSNumber numberWithDouble:newNumber]];
                }
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (currentNum>=newNumber) {
                    timeout=0;
                }else{
                    currentNum = currentNum + 1.50;
                    self.text = [NSString stringWithFormat:@"%.2f",currentNum];
                }
            });
            timeout--;
        }
    });
    dispatch_resume(currTimer);
}

//停止timer
- (void)stopTimer
{
    if (currTimer) {
        dispatch_source_cancel(currTimer);
        currTimer = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.text=@"****";
        });
        
    }
    
}

+ (NSString *)formatterNumberWithComma:(id)number
{
    NSString *numString;
    if ([number isKindOfClass:[NSNumber class]]) {
        numString = [NSString stringWithFormat:@"%lf",[number doubleValue]];
    }else{
        numString = (NSString *)number;
    }
    
    numString = [NSString stringWithFormat:@"%.2lf",[numString doubleValue]];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    [formatter setMaximumFractionDigits:2];
    [formatter setMinimumFractionDigits:2];
    
    NSNumber *num = [NSNumber numberWithDouble:[numString doubleValue]];
    NSString *result = [NSString stringWithFormat:@"%@",[formatter stringFromNumber:num]];
    
    return  result;
}

@end
