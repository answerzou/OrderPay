//
//  CMCollectionViewCell.m
//  LoanInternalPlus
//
//  Created by sandy on 2017/9/5.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMCollectionViewCell.h"

@implementation CMCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
    }
    return self;
}

#pragma mark --
#pragma mark Methords
/**
 *reference:refresh cell with data
 *parameters:object(NSObject instance)
 *return:null
 */
- (void)refreshWithData:(id)object
{
    self.refresh_object = object;
}

- (void)refreshWithData:(id)object indexPath:(NSIndexPath*)indexPath
{
    self.refresh_object = object;
}

/**
 *reference:get complex height
 *parameters:object(NSObject instance)
 *return:float value
 */
+ (CGFloat)complexHeight:(id)object
{
    return 44.0f;
}

@end
