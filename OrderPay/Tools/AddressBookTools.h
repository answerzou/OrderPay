//
//  AddressBookTools.h
//  LoanInternalPlus
//
//  Created by mcitosh on 2017/6/15.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBookTools : NSObject {
    BOOL _hasRegister;
}

+ (AddressBookTools *)sharedInstance;
///获取通讯录列表
+ (NSMutableArray *)getAddressBook;
+ (void)addressBookRequestAccess;
@end
