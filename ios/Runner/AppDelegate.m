#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
//#import <Bugly/Bugly.h>
//#import "NHPushManager.h"
//#import <UserNotifications/UserNotifications.h>
//#import "NHVerifyHandler.h"

@interface AppDelegate()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
//    [Bugly startWithAppId:@"76a0e39427"];
//    push只支持iOS10及以上系统
//    if (@available(iOS 10.0, *)) {
//        [NHPushManager.shared setupPushManagerWithLaunchOptions:launchOptions appKey:@"5f277ca98b1bb63ff5857923"];
//        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
//    }
//    [NHVerifyHandler setupVerifySDKWithInfo:@"XSm7pCfQgeq5wLurrd832IT1ptTZhN9fgTZ5rWodQAQb8qDyCTBbfpEntAIUJIp2TGB2DfxDMsnyUGVDcXT29XowzxwmP9RqkWC7lGg7qzZ65XybgMg2R333AhoPfsCKCH6QJ3L8pBtgIWMwRKhd865NM0yQJh5weNZsaRlzghpAfsfsHDc0b37uz7bV96EiQvZQOYzaVq48Im3RhYUDsW8pe/gltETz3y1R8VkNOj5GEKlcJx+HMw=="];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
//    [NHPushManager.shared applicationDidBecomeActive:application];
}

#ifdef __IPHONE_10_0
// APNs注册成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    [NHPushManager.shared application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

// APNs注册失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    [NHPushManager.shared application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

//  App在前台收到推送通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
//    [NHPushManager.shared userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
}

// 用户对通知做出响应：点击进入App、隐藏通知、操作通知时回调（用户点击通知栏通知时会触发）
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
//    [NHPushManager.shared userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
}

#endif

@end

