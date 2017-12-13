//
//  UIViewController+ExtensionFile.m
//  LoanInternalPlus
//
//  Created by ioszhb on 2017/9/20.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "UIViewController+ExtensionFile.h"

@implementation UIViewController (navigationBar)

////创建左导航键
//- (void)initLeftItemWithName:(NSString *)title withImage:(NSString *)imageName
//{
//    UIBarButtonItem * leftItem = [self itemWithTarget:self action:@selector(clickedLeftNavItem:) image:imageName highImage:imageName];
//    self.navigationItem.leftBarButtonItem = leftItem;
//}
//
//- (void)clickedLeftNavItem:(UIBarButtonItem *)leftItem
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//
////+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
//- (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
//{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    // 设置图片
//    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
//    btn.imageEdgeInsets  = UIEdgeInsetsMake(0, 0, 0, -10);
//    btn.contentMode = UIViewContentModeCenter;
//    // 设置尺寸
//    btn.frame = CGRectMake(0, 0,btn.currentImage.size.width + 5, btn.currentImage.size.height + 5);
//    
//    return [[UIBarButtonItem alloc] initWithCustomView:btn];
//}

@end
