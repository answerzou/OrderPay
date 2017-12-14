//
//  JYLocationManager.m
//  SLCityListSearchDemo
//
//  Created by Kim on 2017/11/13.
//  Copyright © 2017年 jieyue. All rights reserved.
//

#import "JYLocationManager.h"

@interface JYLocationManager()<CLLocationManagerDelegate>

/** 定位管理器 */
@property (strong, nonatomic) CLLocationManager *manager;
/** 地理编码和反编码 */
@property (strong, nonatomic) CLGeocoder *geocoder;
/** 所有定位信息 */
@property (copy, nonatomic) LocationPlacemark locationPlacemark;
/** 定位失败 */
@property (copy, nonatomic) LocationFailed locationFailed;
/** 定位状态 */
@property (copy, nonatomic) LocationStatus locationStatus;

@end

@implementation JYLocationManager

static id _instance = nil;

+ (instancetype)sharedInstance {
    return [[self alloc] init];
}
static dispatch_once_t onceToken;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

//+(void)attempDealloc{
//    onceToken = 0; // 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
//    [_instance release];
//    _instance = nil;
//}

- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
        
    });
    return _instance;
}

- (void)getLocationPlacemark:(LocationPlacemark)placemark status:(LocationStatus)status didFailWithError:(LocationFailed)error {
    
    if (placemark) {
        self.locationPlacemark = placemark;
    }
    
    if (status) {
        self.locationStatus = status;
    }
    
    if (error) {
        self.locationFailed = error;
    }
    
    [self locationAction];
}

- (void)locationAction {
    // 定位
    self.manager = [CLLocationManager new];
    self.manager.distanceFilter = 10;
    self.manager.desiredAccuracy = kCLLocationAccuracyKilometer;
    // 2.设置代理
    self.manager.delegate = self;
    
    // 3.请求定位
    //    if ([self.manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
    //        [self.manager requestAlwaysAuthorization];
    //    }
    //     只有使用时才访问位置信息
    if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.manager requestWhenInUseAuthorization];
    }
    
    // 4.开始定位
    [self.manager startUpdatingLocation];
    // 初始化编码器
    self.geocoder = [CLGeocoder new];
    
}

#pragma mark -- 地理位置代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = locations[0];
    // 通常为了节省电量和资源损耗，在获取到位置以后选择停止定位服务
    [self.manager stopUpdatingLocation];
    // 地理反编码
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *placeMark = placemarks[0];
        
        if (self.locationPlacemark) {
            self.locationPlacemark(placeMark);
        }
        
    }];
}

// 定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // 通常为了节省电量和资源损耗，在获取到位置以后选择停止定位服务
    [self.manager stopUpdatingLocation];
    if (self.locationFailed) {
        self.locationFailed(error);
    }
}

// 定位状态改变
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    // 4.开始定位
    [self.manager startUpdatingLocation];
    if (self.locationStatus) {
        self.locationStatus(status);
    }
}



@end
