//
//  NetworkInfoProvider.h
//  Runner
//
//  Created by Adrian on 2020/6/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkInfoProvider : NSObject

+ (instancetype)sharedProvider;

- (NSString *)carrierName;
- (NSString *)carrierType;
- (NSString *)networkType;

@end

NS_ASSUME_NONNULL_END
