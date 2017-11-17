//
//  CMPinyin.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMPinyin : NSObject
@end
@interface NSString (PinYin)
- (NSString*)pinYin;
- (NSString*)firstCharactor;

@end
