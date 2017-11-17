//
//  CMString.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (Adapter)
- (CGSize)sizeWithAdapterFont:(UIFont *)font;
- (void)drawAtPoint:(CGPoint)point withAdapterFont:(UIFont*)font;
- (void)drawInRect:(CGRect)rect withAdapterFont:(UIFont*)font;
- (CGSize)sizeWithAdapterFont:(UIFont*)font constrainedToSize:(CGSize)size;
- (CGSize)sizeWithAdapterFont:(UIFont*)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
@end
@interface CMString : NSObject

@end
