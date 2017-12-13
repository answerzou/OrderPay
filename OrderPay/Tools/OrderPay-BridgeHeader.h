
//
//  OrderPay-BridgeHeader.h
//  OrderPay
//
//  Created by answer.zou on 17/10/20.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

/*
 问题描述：使用Cocoapods时，import 找不到头文件。
 
 问题原因：这是因为还没设置头文件的目录。
 
 解决办法：在项目的Target-Build Settings的里设置一下，添加cocoapods头文件目录：目录路径直接写：${SRCROOT}   ，后边选择recursive 。就可以了。
 
 注意：是在 User Header Search Paths 里添加，不是上面的 Header Search Paths.
 */

#ifndef OrderPay_BridgeHeader_h
#define OrderPay_BridgeHeader_h

#import "JYUtilities.h"
#import "AESCrypt.h"
#import "CityListViewController.h"

//网络请求头文件
#import "CMResponseTip.h"
#import <YYModel/YYModel.h>
#import "CMRequestEngine.h"
#import "CMRequestEngine+HttpTools.h"
#import "CMNetworkMonitor.h"
#import "CMRegular.h"
//#import <AFNetworking/AFNetworkReachabilityManager.h>
//#import <AFNetworking/AFNetworking.h>
#import "MJRefresh.h"
#import "YYWeakProxy.h"
#import "SVProgressHUD.h"
#import "AddressBookTools.h"
#import "JYAddressBookModel.h"
#import "CMTitleAlertView.h"
#import "JYCitySelectManager.h"
#import "CMColor.h"
#import "FMDB.h"
#import "JYDBEngineManage.h"
#import "CMFile.h"
#import "MJExtension.h"
#import "CMDefaultInfoViewTool.h"
#import "CMDefaultInfoView.h"
#import "NSString+JYExtension.h"
#import "UIButton+JYExtension.h"
#import "UIColor+JYColor.h"
#import "UIFont+JYExtension.h"
#import "UIImage+JYExtension.h"
#import "UILabel+JYExtension.h"
#import "UIView+JYExtension.h"
#import "UIViewController+ExtensionFile.h"
#endif /* OrderPay_BridgeHeader_h */
