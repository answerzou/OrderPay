//
//  JYAddressBookModel.h
//  LoanInternalPlus
//
//  Created by jy on 2017/6/9.
//  Copyright © 2017年 捷越联合. All rights reserved.
//  通讯录列表信息

#import <Foundation/Foundation.h>

@interface JYAddressBookModel : NSObject
///用户姓名
@property (nonatomic,copy) NSString *name;
///第一个电话
@property (nonatomic,copy) NSString *telephone1;
@property (nonatomic,copy) NSString *telephone2;
@property (nonatomic,copy) NSString *telephone3;
@end
