//
//  CMGlobalDef.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMToolsDef.h"
//#import "View+MASAdditions.h"

typedef NS_ENUM(NSInteger,JYRouteType)
{
    JYRouteTypeAddInto   = 1 << 0,
    JYRouteTypeAboute   = 1 << 1,
    JYRouteTypeHome   = 1 << 2

};
typedef void(^RouteBlock)(JYRouteType type,id object);


//singleton
#define CM_SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(className) \
\
+ (className *)sharedInstance;
#define CM_SYNTHESIZE_SINGLETON_FOR_CLASS(className) \
\
+ (className*) sharedInstance	\
{\
static className *instance;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instance = [[className alloc] init];\
});\
return instance;\
}

//arc
#define WEAKSELF    typeof(self) __weak weakSelf = self;
#define STRONGSELF  __strong __typeof(&*weakSelf)strongSelf = weakSelf;

//notification
#define CMNetAvailableNotification   @"CMNetworkAvailableNotification"
#define CMNetUnAvailableNotification @"CMNetworkUnAvailableNotification"
#define CMReloginNotification        @"CMReloginNotification"
#define CMRefreshTopPageNotification @"CMRefreshTopPageNotification"

//local string
#define LOCALSTR(string) NSLocalizedString(string, nil)

//image
#define IMG(x) [UIImage imageNamed:x]

//replace
#define AVAILABLY_REPLACE(q) if (!q||[q isKindOfClass:[NSNull class]]){q = @"";}

