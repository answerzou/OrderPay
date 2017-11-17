//
//  CMImage.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "CMGlobalDef.h"
#import <UIKit/UIKit.h>


#define KFingerTipAlbum        (@"CommonTipAlbum")

@interface CMImage : NSObject
/**
 *reference:show photo picker
 *parameters:viewController(delegate UIViewController object)
 *return:null
 */
+ (void)ShowPhotoSelectDlgForControllerView:(UIViewController*)viewController isAllowEditing:(BOOL)isAllowEditing;

/**
 *reference:take photo picker
 *parameters:viewController(delegate UIViewController object) isAllowEditing(whether allow editing)
 *return:null
 */
+ (void)takePhoto:(UIViewController*)viewController isAllowEditing:(BOOL)isAllowEditing;

/**
 *reference:init ALAssetsLibrary,sigle instance
 *parameters:null
 *return:ALAssetsLibrary
 */
+ (ALAssetsLibrary *)defaultAssetsLibrary;

/**
 *reference:get image info from asset
 *parameters:asset
 *return:image info,NSDictionary
 */
+ (NSDictionary *)mediaInfoFromAsset:(ALAsset *)asset;

/**
 *reference:save image to album
 *parameters:image(src image) groupName(group name)
 *return:YES or NO
 */
+ (void)saveImageToAlbum:(UIImage*)image groupName:(NSString*)groupName showTip:(BOOL)bShow;
+ (void)saveImageToAlbumEx:(UIImage*)image groupName:(NSString*)groupName showTip:(BOOL)bShow;
/**
 *reference:save image used name
 *parameters:image(src image),pathName:(full path name) compressionQuality(compression quality)
 *return:YES or NO
 */
+ (BOOL)saveImage:(UIImage*)image pathName:(NSString*)pathName compressionQuality:(CGFloat)value;

/**
 *reference:get thumbnail from one image
 *parameters:image(src image),size(des size)
 *return:des image
 */
+ (UIImage*)imageThumbnail:(UIImage*)image withSize:(CGSize)size;

/**
 *reference:filter Size Image
 *parameters:image(src image),sizeLimit(Limit size)
 *return:YES or NO
 */
+ (BOOL)filterSizeImage:(UIImage*)image sizeLimit:(NSInteger)sizeLimit;
/**
 *reference:get random image name
 *parameters:format:(png/jpg)
 *return:image anme
 */
+ (NSString*)randomImageName:(NSString *)format;
@end
@interface UIImage (ImageWithUIView)
+ (UIImage *)imageWithUIView:(UIView *)view1;
+ (UIImage *)imageWithUIView:(UIView *)view1 andRect:(CGRect)rect;
@end

@interface UIImage (KIAdditions)
- (UIImage *)resizeToSize:(CGSize)size;
- (UIImage *)cropImageWithRect:(CGRect)rect;
+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;
- (UIImage *)halfStretchImage;
@end

@interface UIImage (Color)
- (UIImage *)stretchableImage;
+ (UIImage*)imageWithColor:(UIColor*)color;
+ (UIImage*)imageWithColor:(UIColor*)color radius:(CGFloat)radius;
+ (UIImage*)imageWithColor:(UIColor*)color radius:(CGFloat)radius size:(CGSize)size;
+ (UIImage*)imageWithRadialGradient:(NSArray*)colors size:(CGSize)size;
+ (UIImage*)imageWithLinearGradient:(NSArray*)colors size:(CGSize)size;
@end
