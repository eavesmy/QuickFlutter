# Flutter 基础框架二次封装
封装了些常用工具，省的每次都重新写。

# 架构
## 网络
- Dio 
```
lib/net/filter.dart
lib/net/dial.dart
lib/net/host.dart
````
[ ] Http/Https 控制    
[ ] Post/Get/Put/Delete 方法封装

## 事件
- event_bus
```
lib/event/event.dart // 事件类
lib/event/events.dart // 具体事件
```

## 本地存储
- shared_preferences
```
lib/storage/storage.dart
```

## 初始化
```
lib/init.dart
```

## 开发脚本
```
script/
```
[ ] 一键打包全平台    
[ ] 一键修改 android/ios app 图标及名称    
[ ] 一键添加权限    
[ ] 一键修复缓存错误引起对项目调试失败
