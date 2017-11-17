//
//  CMString.m
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMString.h"

@implementation NSString (Adapter)

- (CGSize)sizeWithAdapterFont:(UIFont *)font
{
    NSDictionary* dic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    return [self sizeWithAttributes:dic];
}

- (void)drawAtPoint:(CGPoint)point withAdapterFont:(UIFont *)font
{
    NSDictionary* dic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    [self drawAtPoint:point withAttributes:dic];
}

- (void)drawInRect:(CGRect)rect withAdapterFont:(UIFont *)font
{
    NSDictionary* dic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    [self drawInRect:rect withAttributes:dic];
}

- (CGSize)sizeWithAdapterFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    NSDictionary* dic = [NSDictionary dictionaryWithObject:font
                                                    forKey:NSFontAttributeName];
    CGRect rect = [self boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:dic
                                     context:nil];
    return  rect.size;
}

- (CGSize)sizeWithAdapterFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSDictionary* dic = [NSDictionary dictionaryWithObject:font
                                                    forKey:NSFontAttributeName];
    CGRect rect = [self boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:dic
                                     context:nil];
    return  rect.size;
}
@end


@implementation CMString
@end
