//
//  CMBaseViewController.m
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMBaseViewController.h"
#import "CMColor.h"
#import "UMMobClick/MobClick.h"
#define BASE_COLOR HRGB(@"edeef8")

@interface CMBaseViewController ()

@end

@implementation CMBaseViewController

#pragma mark --
#pragma mark LifeCycle

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BASE_COLOR;
    
    [CMNotification add:self selector:@selector(handleEnterBackground:)
                   name:UIApplicationDidEnterBackgroundNotification object:nil];
    [CMNotification add:self selector:@selector(handleWillEnterforeground:)
                   name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [CMNotification add:self selector:@selector(handleNetAvailable:)
                   name:CMNetAvailableNotification object:nil];
    [CMNotification add:self selector:@selector(handleNetUnAvailable:)
                   name:CMNetUnAvailableNotification object:nil];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.modalPresentationCapturesStatusBarAppearance = YES;

    NSArray *controllers = self.navigationController.viewControllers;
    if (controllers.count > 1){
        [self initLeftNavigationItem];
    }
    /**
      友盟统计属性初始化
      默认为统计相关界面
     */
    self.umPageStatistics = true;
    self.umViewControllerName = NSStringFromClass([self class]);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.umPageStatistics) {
        if (self.navigationItem.title) {
            [MobClick beginLogPageView:self.navigationItem.title];
            
        }else{
            [MobClick beginLogPageView:self.umViewControllerName];
            
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 友盟统计
    if (self.umPageStatistics) {
        if (self.navigationItem.title) {
            [MobClick endLogPageView:self.navigationItem.title];

        }else{
            [MobClick endLogPageView:self.umViewControllerName];

        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [CMNotification remove:self];
}

#pragma mark --
#pragma mark Methords
/*init left navigationitem*/
- (void)initLeftNavigationItem
{
    UIImage *backImage = IMG(@"nav_back");
    UIImage *backImageP = IMG(@"nav_back");
    UIButton *tmpBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tmpBackButton.showsTouchWhenHighlighted = YES;
    [tmpBackButton setImage:backImage forState:UIControlStateNormal];
    [tmpBackButton setImage:backImageP forState:UIControlStateHighlighted];
    tmpBackButton.frame = CGRectMake(0, 0,40, 20);
    tmpBackButton.imageEdgeInsets = UIEdgeInsetsMake(0, -24, 0, 0);
    [tmpBackButton setExclusiveTouch:YES];
    [tmpBackButton addTarget:self action:@selector(handleBackEvent) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tmpBackButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    self.navigationItem.hidesBackButton = YES;
}

- (void)handleBackEvent
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    if (self.navigationController&&([self.navigationController.viewControllers count] > 1)){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark --
#pragma mark NSNotification
- (void)handleEnterBackground:(NSNotification*)notification
{
}

- (void)handleWillEnterforeground:(NSNotification*)notification
{
}

- (void)handleNetAvailable:(NSNotification*)notification
{
}

- (void)handleNetUnAvailable:(NSNotification*)notification
{
}

@end
