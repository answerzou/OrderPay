//
//  JYCityListView.h
//  JYCashLoan
//
//  Created by Kim on 2017/11/8.
//  Copyright © 2017年 jieyue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlterBlock)(void);

typedef void(^CloseBlock)(NSString *addressStr);

@interface JYCityListView : UIView

@property(nonatomic, strong) CloseBlock closeBlock;

@property(nonatomic ,strong) AlterBlock alertBlock;

- (void)locationAction;

@end
