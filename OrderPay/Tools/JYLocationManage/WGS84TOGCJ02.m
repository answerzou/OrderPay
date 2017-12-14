//
//  WGS84TOGCJ02.m
//  NewProject
//
//  Created by SunJoy on 1/26/15.
//  Copyright (c) 2015 eidolonstudio. All rights reserved.
//

#import "WGS84TOGCJ02.h"

const double jy_a = 6378245.0;
const double jy_ee = 0.00669342162296594323;
const double jy_pi = 3.14159265358979324;

@implementation WGS84TOGCJ02


+(CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc
{
    CLLocationCoordinate2D adjustLoc;
    if([self isLocationOutOfChina:wgsLoc]){
        adjustLoc = wgsLoc;
    }else{
        double adjustLat = [self transformLatWithX:wgsLoc.longitude - 105.0 withY:wgsLoc.latitude - 35.0];
        double adjustLon = [self transformLonWithX:wgsLoc.longitude - 105.0 withY:wgsLoc.latitude - 35.0];
        double radLat = wgsLoc.latitude / 180.0 * jy_pi;
        double magic = sin(radLat);
        magic = 1 - jy_ee * magic * magic;
        double sqrtMagic = sqrt(magic);
        adjustLat = (adjustLat * 180.0) / ((jy_a * (1 - jy_ee)) / (magic * sqrtMagic) * jy_pi);
        adjustLon = (adjustLon * 180.0) / (jy_a / sqrtMagic * cos(radLat) * jy_pi);
        adjustLoc.latitude = wgsLoc.latitude + adjustLat;
        adjustLoc.longitude = wgsLoc.longitude + adjustLon;
    }
    return adjustLoc;
}

//判断是不是在中国
+(BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location
{
    if (location.longitude < 72.004 || location.longitude > 137.8347 || location.latitude < 0.8293 || location.latitude > 55.8271)
        return YES;
    return NO;
}

+(double)transformLatWithX:(double)x withY:(double)y
{
    double lat = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(abs(x));
    lat += (20.0 * sin(6.0 * x * jy_pi) + 20.0 *sin(2.0 * x * jy_pi)) * 2.0 / 3.0;
    lat += (20.0 * sin(y * jy_pi) + 40.0 * sin(y / 3.0 * jy_pi)) * 2.0 / 3.0;
    lat += (160.0 * sin(y / 12.0 * jy_pi) + 320 * sin(y * jy_pi / 30.0)) * 2.0 / 3.0;
    
    return lat;
}

+(double)transformLonWithX:(double)x withY:(double)y
{
    double lon = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(abs(x));
    lon += (20.0 * sin(6.0 * x * jy_pi) + 20.0 * sin(2.0 * x * jy_pi)) * 2.0 / 3.0;
    lon += (20.0 * sin(x * jy_pi) + 40.0 * sin(x / 3.0 * jy_pi)) * 2.0 / 3.0;
    lon += (150.0 * sin(x / 12.0 * jy_pi) + 300.0 * sin(x / 30.0 * jy_pi)) * 2.0 / 3.0;
    
    return lon;
}

@end
