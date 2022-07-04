//
//  CrashReport.h
//  Runner
//
//  Created by Adrian on 2020/7/16.
//

#import "NHBaseChannelModule.h"

NS_ASSUME_NONNULL_BEGIN

@interface CrashReport : NHBaseChannelModule

- (void)registerUserInfo:(NSArray *)userInfo;

- (void)report:(NSArray *)crashInfo;

@end

NS_ASSUME_NONNULL_END
