//
//  CMNetworkMonitor.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMGlobalDef.h"

@interface CMNetworkMonitor : NSObject
CM_SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(CMNetworkMonitor)
- (BOOL)isReachable;
- (void)startNotifier;
@end
