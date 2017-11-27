//
//  JYLocationManager.h
//  SLCityListSearchDemo
//
//  Created by Kim on 2017/11/13.
//  Copyright © 2017年 jieyue. All rights reserved.

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^LocationPlacemark)(CLPlacemark *placemark);
typedef void(^LocationFailed)(NSError *error);
typedef void(^LocationStatus)(CLAuthorizationStatus status);

@interface JYLocationManager : NSObject

+ (instancetype)sharedInstance;

- (void)getLocationPlacemark:(LocationPlacemark)placemark status:(LocationStatus)status didFailWithError:(LocationFailed)error;

@end
