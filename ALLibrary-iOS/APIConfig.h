//
//  APIConfig.h
//  ZLYDoc
//  API信息
//  Created by Ryan on 14-4-14.
//  Copyright (c) 2014年 ZLY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVER_AUTH_USERNAME @"xxc.test"
#define SERVER_AUTH_PASSWORD @"jpRc`PlcT]Uj"

/***************SERVER HOST***************/

#define SERVER_HOST @"http://192.168.0.190:14330/api/"

/***************SERVER API***************/
//登录
#define API_LOGIN @"Users/LoginWithPhone"

@interface APIConfig : NSObject

+ (APIConfig *)defaultConfig;

- (NSString *)getAPIURL:(NSString *)apiName;
@end
