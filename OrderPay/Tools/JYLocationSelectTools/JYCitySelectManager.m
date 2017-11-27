//
//  JYCitySelectManager.m
//  JYCashLoan
//
//  Created by Kim on 2017/11/14.
//  Copyright © 2017年 jieyue. All rights reserved.
//

#import "JYCitySelectManager.h"
#import "JYCityListView.h"

#define UI_navBar_Height 0
#define XHHTuanNumViewHight 400
#define kDeviceWidth           [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight          [UIScreen mainScreen].bounds.size.height

@interface JYCitySelectManager()
{
    JYCityListView *_contentView;
    UIView *_bgView;
}
/** 完成选择城市 */
@property (nonatomic, copy) FinishCitySelect finishCallBack;

@end

@implementation JYCitySelectManager

static UIWindow *_window = nil;

static id _instans = nil;
+ (instancetype)sharedInstance {
    return [[self alloc] init];
}

- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instans = [super init];
        [self setupContent];
    });
    return _instans;
}
/// show
- (void)showInView:(FinishCitySelect)cityName {
    if (cityName) {
        self.finishCallBack = cityName;
    }
    [self showInView];
}

- (void)setupContent {
//    self.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
    //    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
//    self.backgroundColor = [UIColor clearColor];
//    self.userInteractionEnabled = YES;
    //    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0;
//        [self addSubview:_bgView];
        
    }
    if (_contentView == nil) {
        _contentView = (JYCityListView *)[[[NSBundle mainBundle] loadNibNamed:@"JYCityListView" owner:self options:nil] lastObject];
        __weak typeof(self) weakSelf = self;
       
        _contentView.closeBlock = ^(NSString *addressStr) {
            [weakSelf disMissView];
            if (weakSelf.finishCallBack) {
                 weakSelf.finishCallBack(addressStr);
            }
        };
        _contentView.alertBlock = ^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"允许“城市列表”在您使用该应用时访问您的位置吗？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [_window.rootViewController presentViewController:alertController animated:YES completion:nil];
        };
    }
}

//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView{
    if (_window == nil) {
        _window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _window.rootViewController = [UIViewController new];
        _window.windowLevel = UIWindowLevelAlert;
        _window.backgroundColor = [UIColor clearColor];
        _window.hidden = NO;
        _window.alpha = 1.f;
//        [_window addSubview:self];
        [_window.rootViewController.view addSubview:_bgView];
        [_window.rootViewController.view addSubview:_contentView];
    }
    // 启动定位
    [_contentView locationAction];
    [_contentView setFrame:CGRectMake(0, KDeviceHeight, kDeviceWidth, XHHTuanNumViewHight)];
    
    [UIView animateWithDuration:0.5 animations:^{
        _bgView.alpha = 0.6;
        [_contentView setFrame:CGRectMake(0, KDeviceHeight - XHHTuanNumViewHight, kDeviceWidth, XHHTuanNumViewHight)];
    } completion:nil];
}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView {
    [_contentView setFrame:CGRectMake(0, KDeviceHeight - XHHTuanNumViewHight, kDeviceWidth, XHHTuanNumViewHight)];
    [UIView animateWithDuration:0.5
                     animations:^{
                         _window.alpha = 0.0;
                         _bgView.alpha = 0.0;
                         [_contentView setFrame:CGRectMake(0, KDeviceHeight, kDeviceWidth, XHHTuanNumViewHight)];
                     }
                     completion:^(BOOL finished){
                         
//                         [self removeFromSuperview];
                         [_contentView removeFromSuperview];
                         [_bgView removeFromSuperview];
                         
                     }];
    _window.hidden = YES;
    _window = nil;
    
}

@end
