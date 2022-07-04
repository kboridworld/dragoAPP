//
//  NetworkInfoProvider.m
//  Runner
//
//  Created by Adrian on 2020/6/12.
//

#import "NetworkInfoProvider.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <Reachability/Reachability.h>

@implementation NetworkInfoProvider

static NetworkInfoProvider *_provider = nil;
static CTTelephonyNetworkInfo *_network = nil;

+ (instancetype)sharedProvider {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _provider = [[self alloc] init];
        _network = [[CTTelephonyNetworkInfo alloc] init];
    });
    return _provider;
}

- (NSString *)carrierName {
    NSString *name = @"UNKNOWN";
    CTCarrier *carrier = _network.subscriberCellularProvider;
    if (carrier.carrierName.length > 0) {
        name = carrier.carrierName;
    }
    return name;
}

- (NSString *)carrierType {
    NSString *networkCode = _network.subscriberCellularProvider.mobileNetworkCode;
    NSString *name = @"UNKNOWN";
    switch ([networkCode intValue]) {
        case 00: {
            name = @"China_Mobile";
            break;
        }
        case 01: {
            name = @"China_Unicom";
            break;
        }
        case 02: {
            name = @"China_Mobile";
            break;
        }
        case 03: {
            name = @"China_Telecom";
            break;
        }
        case 05: {
            name = @"China_Telecom";
            break;
        }
        case 06: {
            name = @"China_Unicom";
            break;
        }
        case 07: {
            name = @"China_Mobile";
            break;
        }
        case 9: {
            name = @"China_Unicom";
            break;
        }
        case 11: {
            name = @"China_Telecom";
            break;
        }
        case 20: {
            name = @"China_Tietong";
            break;
        }
        default:
            break;
    }
    return [name uppercaseString];
}

- (NSString *)networkType {
//    TODO: 获取网络类型
    return @"5G";
//    NSString *netType = @"UNKNOWN";
//    Reachability *reachability = [Reachability reachabilityForInternetConnection];
//    NetworkStatus status = [reachability currentReachabilityStatus];
//    return nil;
}

@end
