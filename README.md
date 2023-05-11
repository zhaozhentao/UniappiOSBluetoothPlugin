# UniappiOSBluetoothPlugin

### Usage

1. import
```js
const bluetoothModule = uni.requireNativePlugin("BluetoothPlugin-BluetoothModule")
```
2. init

只需要初始化一次。

```js
bluetoothModule.init({}, ret => {
  uni.showToast({ title: ret.message, icon: 'none' })
})
```

蓝牙状态发生变化时回调，message 可能的值如下。

| message |
| ---- |
| 蓝牙状态未知 |
| 蓝牙重置中 |
| 没有蓝牙权限 |
| 蓝牙关闭 |
| 不支持蓝牙 |
| 蓝牙开启 | 

3. scan
```js
bluetoothModule.scan({}, ret => {
  let { name, deviceId } = ret    // your bluetooth data
})
```

4. stopScan
```js
bluetoothModule.stop({})
```
