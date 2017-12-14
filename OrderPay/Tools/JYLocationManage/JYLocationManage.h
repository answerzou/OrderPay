//
//  LocationManager.h
//  NewProject
//
//  Created by dumeng on 22/9/14.
//  Copyright (c) 2014 eidolonstudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>


typedef void(^LocationAuthorizationBlock)(void);
typedef void(^LocationCompleteBlock)(void);

@interface JYLocationManage : NSObject<CLLocationManagerDelegate>

+ (JYLocationManage*) sharedInstance;

@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longitude;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *province;//省
@property (strong, nonatomic) NSString *city;    //市
@property (strong, nonatomic) NSString *county;  //区
@property (strong, nonatomic) NSString *street;  //街道


/**
 请求地理位置权限
 @param locationAuthorizationBlock 允许的回调
 */
- (void)authorizationStatusForLocationController:(UIViewController *)controller locationAuthorizationBlock:(LocationAuthorizationBlock)locationAuthorizationBlock;

- (void)requestLocation;
- (void)requestLocation:(LocationCompleteBlock)locationCompleteBlock;

- (void)stop;


@end
