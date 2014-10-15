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

/***************是否需要鉴权：1、需要 0、不需要***************/
#define SERVER_AUTH_ISNEEDAUTH 0

/***************SERVER HOST***************/

#define SERVER_HOST @"http://www.kuaidi100.com/"

/***************是否打开本地测试环境***************/
#define LOCAL_SERVER_ISOPEN NO

/***************SERVER API***************/
//登录
#define API_LOGIN @"query"

@interface APIConfig : NSObject

+ (APIConfig *)defaultConfig;

- (NSString *)getAPIURL:(NSString *)apiName;
@end
