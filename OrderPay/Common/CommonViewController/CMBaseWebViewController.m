//
//  CMBaseWebViewController.m
//  LoanInternalPlus
//
//  Created by wenglx on 2017/10/3.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMBaseWebViewController.h"
#import "CMColor.h"
#import "CMDefaultInfoView.h"
#import "CMDefaultInfoViewTool.h"
#define kDeviceWidth           [UIScreen mainScreen].bounds.size.width

@interface CMBaseWebViewController ()

@end

@implementation CMBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建webView
    [self setUpWebView];
    // 创建进度条
    [self setUpProgressView];
}

/**
 * 布局
 */
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

/**
 *  创建WebView
 */
- (void)setUpWebView
{
    //进行配置控制器
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    //实例化对象
    configuration.userContentController = [[WKUserContentController alloc] init];
    //重要：调用JS方法
    [configuration.userContentController addScriptMessageHandler:(id<WKScriptMessageHandler>)[[CMWeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"jsCallbackMethod"];
    [configuration.userContentController addScriptMessageHandler:(id<WKScriptMessageHandler>)[[CMWeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"ios_pop"];
    [configuration.userContentController addScriptMessageHandler:(id<WKScriptMessageHandler>)[[CMWeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"updatePageTitle"];
    [configuration.userContentController addScriptMessageHandler:(id<WKScriptMessageHandler>)[[CMWeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"jsCallbackMethodResult"];
    
    
    // 创建webView
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.frame = self.view.bounds;
    
//    NSDictionary *dic = @{
//                          @"appType":AppType,
//                          @"appNo":[JYKeyChainManage readValueWithIdentifier:KEY_IN_KEYCHAIN_UUID],
//                          @"appVersion":AppVersion,
//                          @"token":[JYUser sharedInstance].token
//                          };
    
//
//
//    self.webView.customUserAgent = [self DataTOjsonString:dic];
    [self.view addSubview:self.webView];
    // KVO
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

/**
 *  创建进度条
 */
- (void)setUpProgressView
{
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    self.progressView.frame = CGRectMake(0, 0, kDeviceWidth, 0);
    self.progressView.progressTintColor = HRGB(@"43C01C");
    [self.view addSubview:self.progressView];
}

/**
 *  KVO
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == _webView) {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            if(self.webView.estimatedProgress >= 1.0f) {
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
            }
            if (self.blockProgress) {
                self.blockProgress(0);
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else if ([keyPath isEqualToString:@"title"]) {
        if (object == self.webView) {
            if (self.webView.title.length) {
                self.navigationItem.title = self.webView.title;
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //重要：由子类实现具体内容
}

#pragma mark - WKNavigationDelegate
// 对于HTTPS的都会触发此代理，如果不要求验证，传默认就行
// 如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler
{
    completionHandler(NSURLSessionAuthChallengeUseCredential, nil);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.canGoBack = webView.canGoBack;
    self.canGoForward = webView.canGoForward;
}

- (void)popVC
{
    if ((self.canGoBack == NO && self.canGoForward == NO) || (self.canGoBack == NO && self.canGoForward == YES)) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if (self.canGoBack == YES && self.canGoForward == NO) {
        [self.webView goBack];
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [CMDefaultInfoViewTool dismissFromView:self.webView];
}

// 全局：处理拨打电话以及Url跳转等等
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme isEqualToString:@"tel"]) {
        NSString *resourceSpecifier = [URL resourceSpecifier];
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", resourceSpecifier];
        /// 防止iOS 10及其之后，拨打电话系统弹出框延迟出现
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        });
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [CMDefaultInfoViewTool showLoadFailureView:self.webView];
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    
}

#pragma mark - WKUIDelegate
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
//{
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"测试" message:message preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler();
//    }]];
//
//    [self presentViewController:alert animated:YES completion:nil];
//}

/**
 *  控制器销毁
 */
- (void)dealloc
{
    [self.progressView setAlpha:0.0f];
    [self.progressView removeFromSuperview];
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

/**
 *  清除缓存
 */
- (void)cleanWebViewCache
{
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0) {
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        }];
    } else {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
}
@end
