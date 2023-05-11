//
//  BlueToothModule.h
//  BlueToothPlugin
//
//  Created by 招振涛 on 2023/5/8.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "DCUniModule.h"

NS_ASSUME_NONNULL_BEGIN

@interface BluetoothModule : DCUniModule<CBCentralManagerDelegate>

@property (strong, nonatomic) CBCentralManager * centralManager;
@property (strong, nonatomic) CBPeripheral * peripheral;

@end

NS_ASSUME_NONNULL_END
