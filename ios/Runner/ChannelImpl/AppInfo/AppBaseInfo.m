//
//  AppBaseInfo.m
//  Runner
//
//  Created by Adrian on 2020/6/12.
//

#import "AppBaseInfo.h"
#import <OpenUDID/OpenUDID.h>
#import "NetworkInfoProvider.h"
#import <UIKit/UIKit.h>
#import "NSObject+YYModel.h"

@interface AppBaseInfo()

/// 设备唯一标识
@property(nonatomic, copy) NSString *dfp;

/// 设备型号
@property(nonatomic, copy) NSString *modelName;

/// 系统版本号
@property(nonatomic, copy) NSString *osVersion;

/// 包名
@property(nonatomic, copy) NSString *packageName;

/// 渠道名称：App Store
@property(nonatomic, copy) NSString *channelName;

/// 版本号（int）：3.12.3.0 -> 3120300
@property(nonatomic, assign) NSInteger versionCode;

/// 版本号（String）：3.12.3.0
@property(nonatomic, copy) NSString *versionName;

/// 运营商名称
@property(nonatomic, copy) NSString *carrierType;

/// 网络类型
@property(nonatomic, copy) NSString *networkType;

@end

@implementation AppBaseInfo

static AppBaseInfo *_info = nil;

- (instancetype)init {
    if (self = [super init]) {
        _channelName = @"App Store";
        _dfp = [OpenUDID value];
        _osVersion = [UIDevice currentDevice].systemVersion;
        _modelName = [UIDevice currentDevice].model;
        _packageName = [[NSBundle mainBundle] bundleIdentifier];
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        _versionName = [infoDic objectForKey:@"CFBundleShortVersionString"];
        _versionCode = [self appVersionCodeFromVersionString:_versionName];
        _carrierType = [NetworkInfoProvider.sharedProvider carrierType];
        _networkType = [NetworkInfoProvider.sharedProvider networkType];
    }
    return self;
}

+ (NSString *)jsonString {
    if (_info == nil) {
        _info = [[self alloc] init];
    }
    return _info.yy_modelToJSONString;
}

// 1.12.1 => 1120100
- (NSUInteger)appVersionCodeFromVersionString:(NSString *)versionString {
    NSUInteger version = 0;
    if (versionString.length == 0) {
        return version;
    }
    NSMutableArray<NSString *> *versions = [versionString componentsSeparatedByString:@"."].mutableCopy;
    if (versions.count == 0) {
        return version;
    }
    NSUInteger scale = 1000000;
    for (NSString *vPart in versions) {
        NSUInteger vPartInt = [vPart integerValue];
        version += vPartInt * scale;
        scale /= 100;
    }
    return version;
}

@end
