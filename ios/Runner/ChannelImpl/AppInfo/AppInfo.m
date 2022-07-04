//
//  AppInfo.m
//  Runner
//
//  Created by Adrian on 2020/6/1.
//

#import "AppInfo.h"
#import <nh_flutter_native_channel/NhFlutterNativeChannelPlugin.h>
#import "AppBaseInfo.h"
@class AppBasicInfo;

@implementation AppInfo

- (void)appBaseInfo {
    self.result([AppBaseInfo jsonString]);
}




@end


