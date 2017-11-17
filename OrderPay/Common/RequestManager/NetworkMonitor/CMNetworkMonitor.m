//
//  CMNetworkMonitor.m
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMNetworkMonitor.h"
#import "CMNotification.h"
#import "Reachability.h"
#import "CMGlobalDef.h"
#import "AFNetworkReachabilityManager.h"

@interface CMNetworkMonitor ()
@property(nonatomic,strong) Reachability        *cellularReachability;
@property(nonatomic,assign) NetworkStatus       previousNetworkStatus;
@end
@implementation CMNetworkMonitor
CM_SYNTHESIZE_SINGLETON_FOR_CLASS(CMNetworkMonitor)

#pragma mark --
#pragma mark LifeCycle
- (instancetype)init
{
    if (self = [super init]) {
        _cellularReachability = [Reachability reachabilityForInternetConnection];
    }
    return self;
}

- (void)dealloc
{
    [CMNotification remove:self];
}

#pragma mark --
#pragma mark Methords
- (BOOL)isReachable
{
    return [_cellularReachability isReachable];
}

- (void)startNotifier
{
    [CMNotification add:self selector:@selector(reachabilityChanged:)
                   name:kReachabilityChangedNotification object:nil];
    [_cellularReachability startNotifier];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma mark --
#pragma mark NSNotification
- (void)reachabilityChanged:(NSNotification*)notification
{
    Reachability* curReach = [notification object];
    if (curReach != _cellularReachability) return;
    
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    switch (netStatus){
        case NotReachable:{
            if(self.previousNetworkStatus != NotReachable){
               // CRToast(LOCALSTR(@"KeyNetworkFailureCheck"));
            }
            [CMNotification post:CMNetUnAvailableNotification object:nil userInfo:nil];
            break;
        }
        case ReachableViaWWAN:{
            if (self.previousNetworkStatus == ReachableViaWiFi){
               // CRToast(LOCALSTR(@"KeyNetworkUsingWWAN"));
            }
            else if (self.previousNetworkStatus == NotReachable){
               // CRToast(LOCALSTR(@"KeyNetworkRestore"));
            }
            [CMNotification post:CMNetAvailableNotification object:nil userInfo:nil];
            break;
        }
        case ReachableViaWiFi:{
            if (self.previousNetworkStatus == NotReachable){
               // CRToast(LOCALSTR(@"KeyNetworkRestore"));
            }
            [CMNotification post:CMNetAvailableNotification object:nil userInfo:nil];
            break;
        }
    }
    self.previousNetworkStatus = netStatus;
}

@end
