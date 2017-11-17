//
//  JYImagePickerViewModel.m
//  NewEasyRepayment
//
//  Created by jy on 2017/9/11.
//  Copyright © 2017年 jieyuechina. All rights reserved.
//

#import "JYImagePickerViewModel.h"
#import "TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "TZPhotoPreviewController.h"
#import "TZLocationManager.h"

@interface JYImagePickerViewModel ()<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>{
    BOOL _isSelectOriginalPhoto;
    CGFloat _itemWH;
    CGFloat _margin;
}
/**
 调用相机的控制器
 */
@property (nonatomic,strong) UIViewController *cameraVC;
/**
 选择到的图片数组
 */
@property (nonatomic,strong) NSMutableArray *selectedPhotos;
@property (nonatomic,strong) NSMutableArray *selectedAssets;
/**
 图片选择器
 */
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@end

@implementation JYImagePickerViewModel

/**
 绑定图片选择viewmoel
 @param vc 需要此功能的控制器
 */
- (void)addImagePickerViewModelToController:(UIViewController *)vc{
    self.cameraVC = vc;
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    _maxCount = 9;
    _columnNumber = 4;
}

#pragma mark - UIImagePickerController
- (void)takePhoto {
    [_selectedPhotos removeAllObjects];
    [_selectedAssets removeAllObjects];
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (iOS7Later) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self takePhoto];
                    });
                }
            }];
        } else {
            [self takePhoto];
        }
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}
// 调用相机
- (void)pushImagePickerController {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        if(iOS8Later) {
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [self.cameraVC presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}


#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:_maxCount delegate:self];
    /** 四类个性化设置，这些参数都可以不传，此时会走默认设置 */
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;//选择普通照片
    if (_maxCount > 1) {
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = _selectedAssets; //目前已经选中的图片数组
    }
    imagePickerVc.allowTakePicture = false; // 在内部显示拍照按钮
    // 2. 在这里设置imagePickerVc的外观
    //     imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    //     imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    //     imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    //     imagePickerVc.navigationBar.translucent = NO;
    
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = false;//选视频
    imagePickerVc.allowPickingImage = true;//选图片
    imagePickerVc.allowPickingOriginalPhoto = true;//允许选原图
    imagePickerVc.allowPickingGif = false;//选Gif
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = true;
    // imagePickerVc.minImagesCount = 3;
    //     imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO; //单选模式,maxImagesCount为1时才生效
    imagePickerVc.allowCrop = false;//允许裁剪,不能选择原图
    imagePickerVc.needCircleCrop = false;//需要圆形裁剪框
    imagePickerVc.circleCropRadius = 100;//裁剪大小
    imagePickerVc.isStatusBarDefault = NO;//顶部statusBar 是否为系统默认的黑色，默认为NO
    //    imagePickerVc.allowPreview = NO;//默认为YES，如果设置为NO,预览按钮将隐藏,用户将不能去预览照片
    /** 四类个性化设置，这些参数都可以不传，此时会走默认设置---到这里为止, */
    
    // 你可以通过block或者代理，来得到用户选择的照片.
    
    [self.cameraVC presentViewController:imagePickerVc animated:YES completion:nil];
}

// 你可以通过block或者代理，来得到用户选择的照片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos{
    self.selectedPhotos = [NSMutableArray arrayWithArray:photos];
    if (self.imagePickerViewModelBlock) {
        self.imagePickerViewModelBlock(self.selectedPhotos);
    }
}

//实现图片选择器代理
//参数：图片选择器  字典参数
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //通过key值获取到图片
    UIImage * image =info[UIImagePickerControllerOriginalImage];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        [self.selectedPhotos addObject:image];
        if (self.imagePickerViewModelBlock) {
            self.imagePickerViewModelBlock(self.selectedPhotos);
        }
        [self.cameraVC dismissViewControllerAnimated:YES completion:nil];
    }
}

/**
 取消照相
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.cameraVC dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark- 懒加载
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.cameraVC.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.cameraVC.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

@end
