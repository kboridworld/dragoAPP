//
//  DeviceInfo.m
//  Runner
//
//  Created by Adrian on 2020/7/20.
//

#import "DeviceInfo.h"
#import <OpenUDID/OpenUDID.h>

@implementation DeviceInfo

- (void)getDeviceId {
    self.result([OpenUDID value]);
}

@end
