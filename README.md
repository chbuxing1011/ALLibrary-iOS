# ALLibrary-ios 

站在巨人的肩膀上，针对`RTALLibrary-ios`进行了扩展和修改，主要是针对自己使用的项目做一些优化。后续会慢慢添加需要的东西




## 更新日志
`2014.10.14更新`

集成友盟社会化分享插件，在程序内可实现一键分享和摇一摇截图分享，特别要注意的是，微信分享时，需要把`URL Schemes`设置为申请的`key`值，这样才不会出现返回至应用程序错乱的情况。
[![](http://ftpdemo.qiniudn.com/Umeng.1.png)](http://ftpdemo.qiniudn.com/Umeng.1.png)


`2014.10.13更新`

集成`Crittercism`，目前版本`5.0.4`。如果`SDK`有更新，可直接替换`${SRCROOT}/Common/CrittercismSDK`即可。申请新的`App`后，把对应的`APP_ID和API_KEY`复制到`Crittercism.xcconfig`里.

格式如下:


`APP_ID=543b8df7bb94751247000002`

`API_KEY=RpiMACqaFPcvWtn09H2P1MKgPlihcAP8`


在`AppDelegate.m`里，使用如下代码进行处理
```objetivce-c
[Crittercism enableWithAppID:[AppUtils getcrittercismKey] andDelegate:nil];
```



通过读取`Crittercism.xcconfig`里的`APP_ID`来进行处理，代码写的比较搓，先将就着用吧。另外，还需要进行如下配置
[![](http://ftpdemo.qiniudn.com/1.png)](http://ftpdemo.qiniudn.com/1.png)


## 使用说明
1.网络请求发送
```objetivce-c
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:@"18012306580" forKey:@"telphone"];
    
    [[RTHttpClient defaultClient]
     requestWithPath:[[APIConfig defaultConfig] getAPIURL:API_LOGIN]
     method:RTHttpRequestGet
     parameters:param
     prepareExecute:^{}
     
     success:^(NSURLSessionDataTask *task, id responseObject) {
         UserEntity *userEntity =
         [UserEntity modelObjectWithDictionary:responseObject];
         NSLog(@"responseObject: %@", userEntity);
     }
     
     failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
```



## License

`This code is distributed under the terms and conditions of the [MIT license](LICENSE). `


