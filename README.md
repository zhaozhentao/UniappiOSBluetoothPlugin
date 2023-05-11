# UniappiOSBluetoothPlugin

### Usage

1. import
```js
const bluetoothModule = uni.requireNativePlugin("BluetoothPlugin-BluetoothModule")
```
2. init
```js
bluetoothModule.init({}, ret => {
  uni.showToast({ title: ret.message, icon: 'none' })
})

只需要初始化一次

```

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
