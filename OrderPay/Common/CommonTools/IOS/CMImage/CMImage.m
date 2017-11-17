//
//  CMImage.m
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMImage.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
#import <Photos/Photos.h>
#endif
#import "SSKeychain.h"
#import "CMFile.h"
@implementation CMImage

/**
*reference:show photo picker
*parameters:viewController(delegate UIViewController object) isAllowEditing(whether allow editing)
*return:null
*/
+ (void)ShowPhotoSelectDlgForControllerView:(UIViewController*)viewController isAllowEditing:(BOOL)isAllowEditing
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.navigationBar.tintColor = [UIColor colorWithRed:72.0/255.0 green:106.0/255.0 blue:154.0/255.0 alpha:1.0];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = (id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)viewController;
    imagePickerController.allowsEditing = isAllowEditing;
    [viewController presentViewController:imagePickerController animated:YES completion:nil];
}

/**
 *reference:take photo picker
 *parameters:viewController(delegate UIViewController object) isAllowEditing(whether allow editing)
 *return:null
 */
+ (void)takePhoto:(UIViewController*)viewController isAllowEditing:(BOOL)isAllowEditing
{
    if ([self isCameraAvailable] &&[self doesCameraSupportTakingPhotos] &&
        [self isRearCameraAvailable] && [self isFrontCameraAvailable]){
        
        if ([self isCameraAvailable] &&[self doesCameraSupportTakingPhotos] &&
            [self isRearCameraAvailable] && [self isFrontCameraAvailable]){
            
            NSString *mediaType = AVMediaTypeVideo;// Or AVMediaTypeAudio
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            if(authStatus == AVAuthorizationStatusRestricted ||
               authStatus == AVAuthorizationStatusDenied){
                [self showCameraAuthorityAlertView];
            }
            else if(authStatus == AVAuthorizationStatusAuthorized){
                NSLog(@"Authorized");
                UIImagePickerController *controller =
                [[UIImagePickerController alloc] init];
                controller.sourceType = UIImagePickerControllerSourceTypeCamera;
                NSString *requiredMediaType = (NSString *)kUTTypeImage;
                controller.mediaTypes = [NSArray arrayWithObjects:requiredMediaType, nil];
                controller.videoQuality = UIImagePickerControllerQualityTypeLow;
                controller.allowsEditing = isAllowEditing;
                controller.delegate = (id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)viewController;
                [viewController presentViewController:controller animated:YES completion:nil];
            }
            else if(authStatus == AVAuthorizationStatusNotDetermined){
                [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted){
                    if(granted){
                        NSLog(@"Granted access to %@", mediaType);
                    }
                    else {
                        NSLog(@"Not granted access to %@", mediaType);
                    }
                }];
            }
            else {
                NSLog(@"Unknown authorization status");
            }
        }
    }
    else {
        NSLog(@"not support!");
    }
}

+ (BOOL) isCameraAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL) isFrontCameraAvailable
{
    return [UIImagePickerController
            isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    
}

+ (BOOL) isRearCameraAvailable
{
    return [UIImagePickerController
            isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    
}

+ (BOOL) doesCameraSupportTakingPhotos
{
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage
                          sourceType:UIImagePickerControllerSourceTypeCamera];
    
}

+ (BOOL)cameraSupportsMedia:(NSString *)paramMediaType
                 sourceType:(UIImagePickerControllerSourceType)paramSourceType
{
    __block BOOL result = NO;
    
    if ([paramMediaType length] == 0){
        NSLog(@"Media type is empty.");
        return NO;
    }
    
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:
     ^(id obj, NSUInteger idx, BOOL *stop) {
         NSString *mediaType = (NSString *)obj;
         if ([mediaType isEqualToString:paramMediaType]){
             result = YES;
             *stop= YES;
         }
     }];
    
    return result;
}

/**
 *reference:init ALAssetsLibrary,sigle instance
 *parameters:null
 *return:ALAssetsLibrary
 */
+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred,^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}

/**
 *reference:get image info from asset
 *parameters:asset
 *return:image info,NSDictionary
 */
+ (NSDictionary *)mediaInfoFromAsset:(ALAsset *)asset
{
    NSMutableDictionary *mediaInfo = [NSMutableDictionary dictionary];
    [mediaInfo setObject:[asset valueForProperty:ALAssetPropertyType] forKey:@"UIImagePickerControllerMediaType"];
    [mediaInfo setObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]] forKey:@"UIImagePickerControllerOriginalImage"];
    [mediaInfo setObject:[[asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]] forKey:@"UIImagePickerControllerReferenceURL"];
    
    return mediaInfo;
}

/**
 *reference:save image to album
 *parameters:image(src image) target(target) selector(sel methor)
 *return:YES or NO
 */
+ (void)showCameraAuthorityAlertView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                           message:LOCALSTR(@"KeyCameraAuthorityMessage")
                                                          delegate:nil
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:LOCALSTR(@"KeyCommonItemOK"), nil];
        [alertView  show];
    });
}

+ (void)showAlbumAuthorityAlertView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                           message:LOCALSTR(@"KeyAlbumAuthorityMessage")
                                                          delegate:nil
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:LOCALSTR(@"KeyCommonItemOK"), nil];
        [alertView  show];
    });
}

+ (void)showSaveImageTip:(BOOL)bSuccess
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!bSuccess){
           // CMToast(LOCALSTR(@"KeyInvoiceSaveToAlbumFail"));
        }
        else{
          //  CMToast(LOCALSTR(@"KeyInvoiceSaveToAlbumSuccess"));
        }
    });
}

+ (void)saveToAlbumWithGroup:(ALAssetsGroup*)group image:(UIImage*)image showTip:(BOOL)bShow
{
    if (!group || !image) return;
    WEAKSELF;
    ALAssetsLibrary *assetsLibrary = [self defaultAssetsLibrary];
    [assetsLibrary writeImageToSavedPhotosAlbum:[image CGImage] metadata:nil
                                completionBlock:^(NSURL *assetURL, NSError *error) {
                                    STRONGSELF;
                                    if (!error){
                                        [assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                                            [group addAsset:asset];
                                            if (bShow){
                                                [strongSelf showSaveImageTip:YES];
                                            }
                                        } failureBlock:^(NSError *error) {
                                            if (bShow){
                                                [strongSelf showSaveImageTip:NO];
                                            }
                                        }];
                                    }
                                    else{
                                        if (bShow){
                                            [strongSelf showSaveImageTip:NO];
                                        }
                                    }
                                }];
}

+ (void)saveImageToAlbum:(UIImage*)image groupName:(NSString*)groupName  showTip:(BOOL)bShow
{
    if (!image || groupName.length == 0) return;
    
    ALAssetsLibrary * assetsLibrary = [self defaultAssetsLibrary];
    __block NSMutableArray* groups = [NSMutableArray array];
    
    WEAKSELF;
    __block ALAssetsGroup* fingerTipGroup = nil;
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop){
        STRONGSELF;
        if (!group){
            for (ALAssetsGroup *gp in groups){
                NSString *name = [gp valueForProperty:ALAssetsGroupPropertyName];
                if ([name isEqualToString:groupName]){
                    fingerTipGroup = gp;
                    //save to Album
                    [strongSelf saveToAlbumWithGroup:gp image:image showTip:bShow];
                    break;
                }
            }
            
            if (!fingerTipGroup){
                [assetsLibrary addAssetsGroupAlbumWithName:groupName
                                               resultBlock:^(ALAssetsGroup *gg){
                                                   if (gg){
                                                       //save to Album
                                                       [strongSelf saveToAlbumWithGroup:gg image:image showTip:bShow];
                                                   }
                                                   else{
                                                       if (bShow){
                                                           [strongSelf showSaveImageTip:NO];
                                                       }
                                                   }
                                               }
                                              failureBlock:^(NSError* myerror){
                                                  if (bShow){
                                                      [strongSelf showSaveImageTip:NO];
                                                  }
                                              }];
            }
        }
        else{
            [groups addObject:group];
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *myerror) {
        STRONGSELF;
        if (myerror.code == ALAssetsLibraryAccessUserDeniedError ||
            myerror.code == ALAssetsLibraryAccessGloballyDeniedError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (bShow){
                    [strongSelf showAlbumAuthorityAlertView];
                }
            });
        }
    };
    
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:listGroupBlock failureBlock:failureBlock];
}

+ (void)saveImageToAlbumEx:(UIImage*)image groupName:(NSString*)groupName  showTip:(BOOL)bShow
{
    if (groupName.length == 0) return;
    
    WEAKSELF;
    PHPhotoLibrary* photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
    [photoLibrary performChanges:^{
        PHAssetCollectionChangeRequest* collectionRequest;
        PHFetchResult* fetchCollectionResult;
        
        NSString * uniquenessStr = [SSKeychain passwordForService:KFingerTipAlbum account:@"alias"];
        
        if (uniquenessStr.length > 0){
            fetchCollectionResult = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[uniquenessStr] options:nil];
            if ([fetchCollectionResult count] > 0){
                PHAssetCollection* exisitingCollection = fetchCollectionResult.firstObject;
                collectionRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:exisitingCollection];
            }
            else{
                collectionRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:groupName];
                NSString* identifier = collectionRequest.placeholderForCreatedAssetCollection.localIdentifier;
                if (identifier.length > 0){
                    [SSKeychain setPassword:identifier forService:KFingerTipAlbum account:@"alias"];
                }
            }
        }
        else{
            collectionRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:groupName];
            NSString* identifier = collectionRequest.placeholderForCreatedAssetCollection.localIdentifier;
            if (identifier.length > 0){
                [SSKeychain setPassword:identifier forService:KFingerTipAlbum account:@"alias"];
            }
        }
        
        PHAssetChangeRequest *createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        PHObjectPlaceholder *assetPlaceholder = [createAssetRequest placeholderForCreatedAsset];
        [collectionRequest addAssets:@[assetPlaceholder]];
        
    } completionHandler:^(BOOL success, NSError *error){
        STRONGSELF;
        if (bShow){
            [strongSelf showSaveImageTip:success];
        }
    }];
}

/**
 *reference:save image used name
 *parameters:image(src image),path(full path without),name:(image name) compressionQuality(compression quality),format:(png/jpeg)
 *return:YES or NO
 */
+ (BOOL)saveImage:(UIImage*)image path:(NSString*)path name:(NSString*)name compressionQuality:(CGFloat)value format:(NSString *)format
{
    if (!image || !path) return NO;
    
    UIImage *comImage = image;
    
    NSData* data = nil;
    if([format isEqualToString:@"png"]){
        data = UIImagePNGRepresentation(comImage);
    }
    else {
        if(![self filterSizeImage:comImage sizeLimit:1024*1024*3]){
            data = UIImageJPEGRepresentation(comImage, value);
            comImage = [UIImage imageWithData:data];
        }
        if (!data) {
            data = UIImageJPEGRepresentation(comImage, 1.0f);
        }
    }
    
    if (![CMFile adjustFileAtPath:path]){
        [CMFile createDirectoryAtPath:path];
    }
    NSString* strName = [NSString stringWithString:name];
    if (!strName || ([strName length] == 0)){
        strName = [self randomImageName:format];
    }
    
    BOOL bRet = [data writeToFile:[NSString stringWithFormat:@"%@%@",path,strName] atomically:YES];
    return bRet;
}

+ (NSString*)randomImageName
{
    //get timestamp
    NSTimeInterval var = [[NSDate date] timeIntervalSince1970];
    NSInteger rand = [self getRandomNumber:100000 to:999999];
    return [NSString stringWithFormat:@"%.0f%ld.jpeg",var*1000,(long)rand];
}

/**
 *reference:save image used name
 *parameters:image(src image),pathName:(full path name) compressionQuality(compression quality)
 *return:YES or NO
 */
+ (BOOL)saveImage:(UIImage*)image pathName:(NSString*)pathName compressionQuality:(CGFloat)value
{
    if (!image || pathName.length == 0) return NO;
    
    NSData* data = UIImageJPEGRepresentation(image, value);
    NSError* error = nil;
    BOOL bRet = [data writeToFile:pathName options:NSDataWritingFileProtectionNone error:&error];
    NSLog(@"%@",error.description);
    return bRet;
}

/**
 *reference:get thumbnail from one image
 *parameters:image(src image),size(des size)
 *return:des image
 */
+ (UIImage*)imageThumbnail:(UIImage*)image withSize:(CGSize)size
{
    if (image == nil) return nil;
    
    CGImageRef imageRef = [image CGImage];
    UIImage *thumb = nil;
    
    float _width = CGImageGetWidth(imageRef);
    float _height = CGImageGetHeight(imageRef);
    
    float _resizeToWidth = size.width;
    float _resizeToHeight = size.height;
    
    float _moveX = 0.0f;
    float _moveY = 0.0f;
    
    // resize the image if it is bigger than the screen only
    if ((_width > _resizeToWidth) || (_height > _resizeToHeight)){
        float _amount = 0.0f;
        if (_width > _resizeToWidth){
            _amount = _resizeToWidth / _width;
            _width *= _amount;
            _height *= _amount;
        }
        
        if (_height > _resizeToHeight){
            _amount = _resizeToHeight / _height;
            _width *= _amount;
            _height *= _amount;
        }
    }
    
    _width = (NSInteger)_width;
    _height = (NSInteger)_height;
    _resizeToWidth = _width;
    _resizeToHeight = _height;
    
    CGContextRef bitmap = CGBitmapContextCreate(
                                                NULL,
                                                _resizeToWidth,
                                                _resizeToHeight,
                                                CGImageGetBitsPerComponent(imageRef),
                                                CGImageGetBitsPerPixel(imageRef)*_resizeToWidth,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef)
                                                );
    // now center the image
    _moveX = (_resizeToWidth - _width) / 2;
    _moveY = (_resizeToHeight - _height) / 2;
    
    CGContextSetRGBFillColor(bitmap, 1.f, 1.f, 1.f, 1.0f);
    CGContextFillRect( bitmap, CGRectMake(0, 0, _resizeToWidth, _resizeToHeight));
    CGContextDrawImage( bitmap, CGRectMake(_moveX, _moveY, _width, _height), imageRef);
    
    // create a templete imageref.5
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    
    //CGFloat temp = (self.portrait==1)?1.21412:1.0;
    thumb = [UIImage imageWithCGImage:ref scale:1.0 orientation:image.imageOrientation];
    //thumb = thumb = [UIImage imageWithCGImage:ref];
    
    // release the templete imageref.
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    return thumb;
}

/**
 *reference:filter Size Image
 *parameters:image(src image),sizeLimit(Limit size)
 *return:YES or NO
 */
+ (BOOL)filterSizeImage:(UIImage*)image sizeLimit:(NSInteger)sizeLimit
{
    NSData* data = UIImageJPEGRepresentation(image, 1.0f);
    if(data.length>sizeLimit)
        return NO;
    
    return YES;
}

/**
 *reference:get random image name
 *parameters:null
 *return:image anme
 */
+ (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to
{
    return (NSInteger)(from+(arc4random()%(to-from +1)));
}

/**
 *reference:get random image name
 *parameters:format:(png/jpg)
 *return:image anme
 */
+ (NSString*)randomImageName:(NSString *)format
{
    //get timestamp
    NSTimeInterval var = [[NSDate date] timeIntervalSince1970];
    NSInteger rand = [self getRandomNumber:100000 to:999999];
    return [NSString stringWithFormat:@"%.0f%zd.%@",var*1000,rand,format];
}
@end

@implementation UIImage (ImageWithUIView)
+ (UIImage *)imageWithUIView:(UIView *)view1
{
    CGSize screenShotSize = view1.bounds.size;
    UIGraphicsBeginImageContextWithOptions(screenShotSize,YES,0.0);
    [view1 drawViewHierarchyInRect:view1.bounds afterScreenUpdates:NO];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *)imageWithUIView:(UIView *)view1 andRect:(CGRect)rect
{
    CGSize screenShotSize = rect.size;
    UIGraphicsBeginImageContextWithOptions(screenShotSize,NO,1.0);
    [view1 drawViewHierarchyInRect:CGRectMake(0, 0, screenShotSize.width, screenShotSize.height) afterScreenUpdates:NO];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end

@implementation UIImage (KIAdditions)
- (UIImage *)resizeToSize:(CGSize)size
{
    float imageWidth = self.size.width;
    float imageHeight = self.size.height;
    
    float widthScale = imageWidth /size.width;
    float heightScale = imageHeight /size.height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), YES,0.0);
    
    if (widthScale > heightScale) {
        [self drawInRect:CGRectMake(0, 0, imageWidth /heightScale , size.height)];
    }
    else {
        [self drawInRect:CGRectMake(0, 0, size.width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return newImage;
}

//图片裁剪
- (UIImage *)cropImageWithRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}

/*两张图片合成*/
+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2
{
    UIGraphicsBeginImageContextWithOptions(image1.size, YES,1.0);
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    // Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

- (UIImage *)halfStretchImage
{
    CGSize size = self.size;
    return [self stretchableImageWithLeftCapWidth:size.width/2 topCapHeight:size.height/2];
}
@end

@implementation UIImage (Color)
- (UIImage *)stretchableImage
{
    CGSize size = self.size;
    return [self stretchableImageWithLeftCapWidth:size.width/2 topCapHeight:size.height/2];
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [UIImage imageWithColor:color radius:0];
}

+ (UIImage *)imageWithColor:(UIColor *)color radius:(CGFloat)radius
{
    return [UIImage imageWithColor:color radius:radius size:CGSizeMake(10.0f, 10.0f)];
}

+ (UIImage *)imageWithColor:(UIColor *)color radius:(CGFloat)radius size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    UIGraphicsBeginImageContextWithOptions((CGSizeMake(path.bounds.origin.x  + path.bounds.size.width, path.bounds.origin.y + path.bounds.size.height)), NO, .0);
    [color set];
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image stretchableImage];
}

+ (UIImage *)imageWithRadialGradient:(NSArray *)colors size:(CGSize)size
{
    CGPoint center = CGPointMake(size.width * 0.5, size.height * 0.5);
    CGFloat innerRadius = 0;
    CGFloat outerRadius = sqrtf(size.width * size.width + size.height * size.height) * 0.5;
    
    BOOL opaque = NO;
    UIGraphicsBeginImageContextWithOptions(size, opaque, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    const size_t locationCount = 2;
    CGFloat locations[locationCount] = { 0.0, 1.0 };
    
    NSInteger numberComponents = 0;
    CGFloat colorComponents[colors.count*4];
    for (int i=0; i<colors.count; i++){
        UIColor *color = [colors objectAtIndex:i];
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        numberComponents = CGColorGetNumberOfComponents(color.CGColor);
        
        if (numberComponents == 4){
            colorComponents[i*4+0] = components[0];
            colorComponents[i*4+1] = components[1];
            colorComponents[i*4+2] = components[2];
            colorComponents[i*4+3] = components[3];
        }
        else if (numberComponents == 2){
            colorComponents[i*4+0] = components[0];
            colorComponents[i*4+1] = components[0];
            colorComponents[i*4+2] = components[0];
            colorComponents[i*4+3] = components[1];
        }
        
    }
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, colorComponents, locations, locationCount);
    
    CGContextDrawRadialGradient(context, gradient, center, innerRadius, center, outerRadius, 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
    
    return image;
}

+ (UIImage *)imageWithLinearGradient:(NSArray *)colors size:(CGSize)size
{
    CGPoint startPoint = CGPointMake(0, size.width/2);
    CGPoint endPoint = CGPointMake(0, size.height);
    
    BOOL opaque = NO;
    UIGraphicsBeginImageContextWithOptions(size, opaque, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSInteger numberComponents = 0;
    CGFloat colorComponents[colors.count*4];
    for (int i=0; i<colors.count; i++){
        UIColor *color = [colors objectAtIndex:i];
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        numberComponents = CGColorGetNumberOfComponents(color.CGColor);
        
        if (numberComponents == 4){
            colorComponents[i*4+0] = components[0];
            colorComponents[i*4+1] = components[1];
            colorComponents[i*4+2] = components[2];
            colorComponents[i*4+3] = components[3];
        }
        else if (numberComponents == 2){
            colorComponents[i*4+0] = components[0];
            colorComponents[i*4+1] = components[0];
            colorComponents[i*4+2] = components[0];
            colorComponents[i*4+3] = components[1];
        }
        
    }
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient =  CGGradientCreateWithColorComponents(colorspace, colorComponents, NULL, 2);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
    
    return [image stretchableImage];
}

@end
