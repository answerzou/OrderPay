//
//  JYAddressBookModel.m
//  LoanInternalPlus
//
//  Created by jy on 2017/6/9.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "JYAddressBookModel.h"

@implementation JYAddressBookModel
- (NSString *)name{
    return (_name == nil) ? @"" : _name;
}
- (NSString *)telephone1{
    return (_telephone1 == nil) ? @"" : _telephone1;
}
- (NSString *)telephone2{
    return (_telephone2 == nil) ? @"" : _telephone2;
}
- (NSString *)telephone3{
    return (_telephone3 == nil) ? @"" : _telephone3;
}
@end
