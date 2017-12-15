//
//  CMCollectionViewCell.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/9/5.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)    id      refresh_object;
/**
 *reference:refresh cell with data
 *parameters:object(NSObject instance)
 *return:null
 */
- (void)refreshWithData:(id)object;
- (void)refreshWithData:(id)object indexPath:(NSIndexPath*)indexPath;
@end
