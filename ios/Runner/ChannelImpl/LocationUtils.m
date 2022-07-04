//
//  LocationUtils.m
//  Runner
//
//  Created by Adrian on 2020/9/26.
//

#import "LocationUtils.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationProvider : NSObject<CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

+ (instancetype)shared;

- (NSInteger)getLocationAccuracy;

@end


static LocationProvider *_provider = nil;

@implementation LocationProvider
    
+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _provider = [[LocationProvider alloc] init];
        
    });
    return _provider;
}

- (instancetype)init {
    if ((self = [super init])) {
        locationManager = [CLLocationManager new];
        locationManager.delegate = self;
    }
    return  self;
}

- (NSInteger)getLocationAccuracy {
    if (@available(iOS 14.0, *)) {
        return locationManager.accuracyAuthorization;
    } else {
        // iOS14以下系统只有精确定位：CLAccuracyAuthorizationFullAccuracy
        return 0;
    }
}

- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    NSLog(@"%@ ---- %s", manager, __FUNCTION__);
}

@end


@implementation LocationUtils

- (void)locationAccuracy {
    self.result(@([LocationProvider.shared getLocationAccuracy]));
}

@end






