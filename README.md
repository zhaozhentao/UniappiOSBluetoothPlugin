# UniappiOSBluetoothPlugin

### 

```json
{
  "name": "BluetoothPlugin",
  "id": "BluetoothPlugin",
  "version": "1.0.0",
  "description": "蓝牙搜索模块",
  "_dp_type": "nativeplugin",
  "_dp_nativeplugin": {
    "ios": {
      "plugins": [{
        "type": "module",
        "name": "BluetoothPlugin-BluetoothModule",
        "class": "BluetoothModule"
      }],
      "frameworks": ["MapKit.framework"],
      "integrateType": "framework",
      "deploymentTarget": "12.0"
    }
  }
}
```

### Usage

1. import
```javascript
const bluetoothModule = uni.requireNativePlugin("BluetoothPlugin-BluetoothModule")
```
2. init

只需要初始化一次。

```javascript
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
```javascript
bluetoothModule.scan({}, ret => {
  let { name, deviceId } = ret    // your bluetooth data
})
```

4. stopScan
```javascript
bluetoothModule.stop({})
```
### Demo

```javascript
<template>
  <div style="padding: 10px">
    <button type="default" @click="init">初始化</button>
    <button type="primary" @click="scan">扫描</button>
	
    <div style="margin-top: 10px">蓝牙列表: </div>

    <div v-for="bluetooth in bluetooths">
      <button style="text-align: left;" type="default" @click="connect(blueTooth['name'])">
        <div>
          name: {{ bluetooth['name'] }}
        </div>
        <div>
          deviceId: {{ bluetooth['deviceId'] }}
        </div>
      </button>
    </div>
  </div>
</template>

<script>
// 首先需要通过 uni.requireNativePlugin("ModuleName") 获取 module
const bluetoothModule = uni.requireNativePlugin("BluetoothPlugin-BluetoothModule")

export default {
  data() {
    return {
      bluetooths: []
    }
  },
  methods: {
    init() {
      bluetoothModule.init({}, ret => {
        uni.showToast({ title: ret.message, icon: 'none' })
      })
    },
    scan() {
      uni.showLoading({ title: "搜索中" })

      bluetoothModule.scan({}, ret => {
        let { name, deviceId } = ret		
        this.bluetooths.push({ name, deviceId }) 
      })
			
      setTimeout(() => {
        uni.hideLoading()
			
        uni.showToast({ title: '搜索完成', icon: 'none' })
				
        bluetoothModule.stop({})
      }, 3000)			
    }
  }
}
</script>

<style>
button {
  margin-top: 10px;
}
</style>

```
