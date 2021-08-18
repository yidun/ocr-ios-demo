# 身份证 OCR

## 平台支持（兼容性）

| 条目        | 说明                                                         |
| ----------- | ------------------------------------------------------------ |
| 适配版本    | iOS8以上                                                     |
| 开发环境    | Xcode 11.4                                                    |

## 环境准备

[ CocoaPods 安装教程](https://guides.cocoapods.org/using/getting-started.html)

## 资源引入/集成

### 通过 CocoaPods 自动集成

podfile 里面添加以下代码：

```ruby
 source 'https://github.com/CocoaPods/Specs.git' // 指定下载源
 
# 以下两种版本选择方式示例

# 集成最新版SDK:
pod 'NTESOcrSDK'

# 集成指定SDK，具体版本号可先执行 pod search NTESOcrSDK，根据返回的版本信息自行决定:
pod 'NTESOcrSDK', '~> 1.0.1'
```

* 保存并执行 pod install 即可，若未执行 pod repo update，请执行pod install --repo-update

### 手动集成
* 1、添加易盾SDK,将压缩包中所有资源添加到工程中(请勾选Copy items if needed选项)
* 2、添加依赖库，在项目设置target -> 选项卡General ->Linked Frameworks and Libraries添加如下依赖库，如果已存在如下的系统framework，则忽略： 
	* `AVFoundation.framework`
	* `CoreMedia.framework`
	* `AssetsLibrary.framework`
	* `CoreData.framework`

## 项目开发配置

* 1、在Xcode中找到`TARGETS-->Build Setting-->Linking-->Other Linker Flags`在这个选项中需要添加 `-ObjC`
* 2、将引入SDK头文件的.m文件重命名为.mm文件 或者 在Xcode中找到`TARGETS-->Build Setting-->Apple Clang - Language-->Compile Source As`在这个选项中选择 `Objective-C++`
* 3、在 info.plist 里增加相机权限
```
<!-- 相册 -->   
<key>NSPhotoLibraryUsageDescription</key>   
<string>App需要您的同意,才能访问相册</string>   
<!-- 相机 -->   
<key>NSCameraUsageDescription</key>   
<string>App需要您的同意,才能访问相机</string> 
```

## 调用示例

```
@property (nonatomic, strong) NTESLiveDetectManager *detector;

/// 初始化
self.manager = [[NTESOcrSdkManager alloc] initWithImageView:imageView scanRect:CGRectMake((SCREEN_WIDTH - 360 * KWidthScale)/2, 240, 360 * KWidthScale, 227 * KHeightScale)];

/// 开始身份证识别
[self.manager startDetectWithBusinessID:@"yourbusinessid" cardReverseType:(NTESCardReverseType)self.detectType completionHandler:^(NTESOcrStatus status, NSDictionary * _Nullable params) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf showToastWithLiveDetectStatus:status params:params];
    });
}];
```
  
## SDK 方法说明

### 1 初始化

在项目需要使用 SDK 的文件中先引入  #import <NTESOcrSdk/NTESOcrSdk.h> 然后再初始化的 SDK，如下：

```
@property (nonatomic, strong) NTESOcrSdkManager *detector;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[NTESOcrSdkManager alloc] initWithImageView:imageView scanRect:CGRectMake((SCREEN_WIDTH - 360 * KWidthScale)/2, 240, 360 * KWidthScale, 227 * KHeightScale)];
}
```		
#### 参数说明：

|参数|类型|是否必填|默认值|描述|
|----|----|--------|------|----|
| imageView |UIImageView|是|无|传入放置 OCR 的imageView对象
|  scanRect |CGRect|是|无|身份证扫描框相对于传入放置检测的imageView对象的坐标|
		
### 2 开始身份证识别

#### 代码说明：

```
[self.manager startDetectWithBusinessID:@"易盾分配的业务ID" cardReverseType:NTESCardReverseTypeFront completionHandler:^(NTESOcrStatus status, NSDictionary * _Nullable params) {
    
}
```   

 * 参数说明：

    |参数|类型|是否必填|默认值|描述|
    |----|----|--------|------|----|
    | businessID |NSString|是|无|易盾分配的业务id|
    | cardReverseType |enum|是|NTESCardReverseTypeFront|身份证检测的方向。传入NTESCardReverseTypeFront表示正面检测，NTESCardReverseTypeBack表示国徽面检测|
	
* completionHandler 回调参数说明

    |回调字段|类型|描述|
    |---|----|-----|
    |status|enum| </br>NTESOcrBusinessIdAvailable 业务ID可用</br>  </br>NTESOcrBusinessIdInvalid  业务ID不可用</br>   </br>NTESOcrCheckPass 身份证检测通过</br> </br>NTESOcrCheckNotPass         身份证检测不通过</br></br> NTESOcrGetConfTimeout   身份证测获取配置信息超时</br></br>NTESOcrOperationTimeout  操作超时，用户未在规定时间内完成动作</br></br>NTESOcrNonGateway           网络未连接</br></br>NTESOcrSDKError SDK内部发生错误</br> </br>NTESOcrCameraNotAvailable   App未获取相机权限</br>|
    |params|NSDictionary| @"imageFilePath":"身份证图片路径"|

### 3 停止身份证检测  

#### 代码说明：

```
[self.detector stopDetect];
```
	
### 4 设置检测的超时时间

#### 代码说明：

```
[self.detector setTimeoutInterval:timeoutInterval];
```
#### 参数说明：

|类型|是否必填|默认值|描述|
|----|--------|------|----|
|NSTimeInterval|是|120|请传入1-1800范围内的时间值，单位s|
 
