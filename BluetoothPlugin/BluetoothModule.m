//
//  BlueToothModule.m
//  BlueToothPlugin
//
//  Created by 招振涛 on 2023/5/8.
//

#import "BluetoothModule.h"
#import "DCUniDefine.h"
#import <CoreBluetooth/CoreBluetooth.h>

@implementation BluetoothModule

UNI_EXPORT_METHOD_SYNC(@selector(stop:))        // 停止扫描
UNI_EXPORT_METHOD(@selector(init:callback:))    // 初始化
UNI_EXPORT_METHOD(@selector(scan:callback:))    // 扫描

UniModuleKeepAliveCallback initCallback, scanCallback;

- (void) init:(NSDictionary *) options callback:(UniModuleKeepAliveCallback) callback {
    if (initCallback != nil) {
        callback(@{@"message": @"无需重复初始化"}, NO);
        return;
    }
    
    initCallback = callback;
    
    self.centralManager = [[CBCentralManager alloc] initWithDelegate: self queue:nil];
}

- (void) scan:(NSDictionary *) options callback:(UniModuleKeepAliveCallback) callback {
    scanCallback = callback;
    
    [self.centralManager scanForPeripheralsWithServices: nil options: nil];
}

- (void) stop:(NSDictionary *) options {
    [self.centralManager stopScan];
}

// MARK: 蓝牙状态更新
- (void) centralManagerDidUpdateState:(CBCentralManager *) central {
    switch (central.state) {
        case CBManagerStateUnknown:
            initCallback(@{@"message": @"蓝牙状态未知"}, YES);
            break;
        case CBManagerStateResetting:
            initCallback(@{@"message": @"蓝牙重置中"}, YES);
            break;
        case CBManagerStateUnsupported:
            initCallback(@{@"message": @"不支持蓝牙"}, YES);
            break;
        case CBManagerStateUnauthorized:
            initCallback(@{@"message": @"没有蓝牙权限"}, YES);
            break;
        case CBManagerStatePoweredOff:
            initCallback(@{@"message": @"蓝牙关闭"}, YES);
            break;
        case CBManagerStatePoweredOn:
            initCallback(@{@"message": @"蓝牙开启"}, YES);
            break;
    }
}

// MARK: 发现蓝牙
- (void) centralManager:(CBCentralManager *) central
  didDiscoverPeripheral:(CBPeripheral *) peripheral
      advertisementData:(NSDictionary *) advertisementData
                   RSSI:(NSNumber *) RSSI {
    if (peripheral.name == nil) {
        return;
    }
    
    NSString *name = peripheral.name;
    
    if (advertisementData != nil) {
        NSString* localName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
        
        if (localName != nil) {
            name = localName;
        }
    }
    
    scanCallback(@{@"name": name, @"deviceId": [peripheral.identifier UUIDString]}, YES);
}

@end
