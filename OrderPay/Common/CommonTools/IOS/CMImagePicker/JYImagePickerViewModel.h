//
//  JYImagePickerViewModel.h
//  NewEasyRepayment
//
//  Created by jy on 2017/9/11.
//  Copyright © 2017年 jieyuechina. All rights reserved.
//  二次封装调用相机和图片选择器
/**
 *使用方法
 imagePickerViewModel = JYImagePickerViewModel()
 imagePickerViewModel?.add(to: self)
 //        imagePickerViewModel?.takePhoto()
 imagePickerViewModel?.pushTZImagePickerController()
 imagePickerViewModel?.imagePickerViewModelBlock = {(imageArray) in
 JYAPPLog(imageArray?.count)
 }
 */

#import <UIKit/UIKit.h>

@interface JYImagePickerViewModel : NSObject{
    //可更改设置
    NSInteger _maxCount; //最多选择
    NSInteger _columnNumber; //一行几个
}
/**
 外部回调图片数组
 */
@property (copy, nonatomic) void(^imagePickerViewModelBlock)(NSMutableArray *imageArray);
/**
 绑定图片选择viewmoel
 @param vc 需要此功能的控制器
 */
- (void)addImagePickerViewModelToController:(UIViewController *)vc;
/**
 选择相机
 */
- (void)takePhoto;
/**
 调用图片选择器
 */
- (void)pushTZImagePickerController;
@end
