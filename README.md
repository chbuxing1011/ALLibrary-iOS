# ALLibrary-ios 

站在巨人的肩膀上，针对RTALLibrary-ios进行了扩展和修改，主要是针对自己使用的项目做一些优化。后续会慢慢添加需要的东西




## 更新日志

2014.10.13更新

集成Crittercism，目前版本5.0.4。如果SDK有更新，可直接替换${SRCROOT}/Common/CrittercismSDK即可
申请新的App后，把对应的APP_ID和API_KEY复制到Crittercism.xcconfig里.

格式如下:


APP_ID=543b8df7bb94751247000002

API_KEY=RpiMACqaFPcvWtn09H2P1MKgPlihcAP8


在AppDelegate.m里，使用如下代码进行处理
```objetivce-c
[Crittercism enableWithAppID:[AppUtils getcrittercismKey] andDelegate:nil];
```



通过读取Crittercism.xcconfig里的APP_ID来进行处理，代码写的比较搓，先将就着用吧。另外，还需要进行如下配置
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

This code is distributed under the terms and conditions of the [MIT license](LICENSE). 


