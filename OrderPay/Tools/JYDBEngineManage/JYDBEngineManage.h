//
//  JYDBEngineManage.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/25.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KCommonFile         @"JY_DB"
#define KCommonName         @"common.db"
#define KDatabaseSecretKey  @")k8&@NN1r*%h"

@interface JYDBEngineManage : NSObject

//db init
+ (void)CR_DB_Init;

@end
