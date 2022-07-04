//
//  CrashReport.m
//  Runner
//
//  Created by Adrian on 2020/7/16.
//

#import "CrashReport.h"
#import <Bugly/Bugly.h>
@implementation CrashReport

- (void)registerUserInfo:(NSArray *)userInfo {
    if (userInfo.count == 0) {
        return;
    }
    NSString *userPhone = userInfo[0];
    [Bugly setUserIdentifier:userPhone];
}

- (void)report:(id)crashInfo {
    NSString *stackTrace = crashInfo[1];
    NSArray *traces = [stackTrace componentsSeparatedByString:@"\n"];
    [Bugly reportExceptionWithCategory:5 name:crashInfo[0] reason:@"" callStack:traces extraInfo:@{} terminateApp:NO];
}

@end
