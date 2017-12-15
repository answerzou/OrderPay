//
//  CMBaseWebViewController.h
//  LoanInternalPlus
//
//  Created by wenglx on 2017/10/3.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMBaseViewController.h"
#import <WebKit/WebKit.h>
#import "CMWeakScriptMessageDelegate.h"

typedef void(^JYWebProgressEventBlock)(NSInteger tag);

@interface CMBaseWebViewController : CMBaseViewController<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>
/** 网页 */
@property (nonatomic, strong) WKWebView *webView;
/** 进度条 */
@property (strong, nonatomic) UIProgressView *progressView;
/** 返回 */
@property(nonatomic,assign)BOOL canGoBack;
/** 前进 */
@property(nonatomic,assign)BOOL canGoForward;

@property(nonatomic,copy) JYWebProgressEventBlock blockProgress;

@property (nonatomic, strong)NSDictionary *baseUADic;

-(NSString*)DataTOjsonString:(id)object;

/**清缓存*/
- (void)cleanWebViewCache;


@end
