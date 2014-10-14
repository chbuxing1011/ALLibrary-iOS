//
//  LoginViewController.m
//  RTLibrary-ios
//
//  Created by Ryan on 14-8-3.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "LoginViewController.h"
#import "RTHttpClient.h"
#import "UserEntity.h"
#import "UserDefaultsUtils.h"
#import "UMSocialSnsPlatformManager.h"
#import "UMSocialSnsViewController.h"
//#import "UMSocialLoginViewController.h"
//#import "UMSocialBarViewController.h"
#import "AppDelegate.h"

//#import "UMSocial.h"
#import "UMSocialScreenShoter.h"

#define kTagShareEdit 101
#define kTagSharePost 102

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString *app_Version =
    [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    self.m_versionLbl.text = app_Version;
    
    //初始化LoginView，设置LoginViewDelegate处理登录视图的事件
    
    //在视图代理方法里通过调用LoginHandler处理登录业务逻辑，发起网络请求和结果处理均在LoginHandler中完成
}
- (IBAction)showShareList1:(id)sender {
    NSString *shareText = @"友" @"盟"
    @"社会化组件可以让移动应用快速具备社会化分享、"
    @"登录、评论、喜欢等功能，"
    @"并提供实时、全面的社会化数据统计分析服务。 "
    @"http://www.umeng.com/social"; //分享内嵌文字
    UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"]; //分享内嵌图片
    
    //如果得到分享完成回调，需要设置delegate为self
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UmengAppkey
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:nil
                                       delegate:self];
}

- (IBAction)setShakeSns:(id)sender {
    //可以设置响应摇一摇阈值，数值越低越灵敏，默认是0.8
    [UMSocialShakeService setShakeThreshold:1.5];
    NSString *shareText = @"友" @"盟"
    @"社会化组件可以让移动应用快速具备社会化分享、"
    @"登录、评论、喜欢等功能，"
    @"并提供实时、全面的社会化数据统计分析服务。 "
    @"http://www.umeng.com/social"; //分享内嵌文字
    //下面设置delegate为self，执行摇一摇成功的回调，不执行回调可以设为nil
    [UMSocialShakeService
     setShakeToShareWithTypes:nil
     shareText:shareText
     screenShoter:[UMSocialScreenShoterDefault screenShoter]
     inViewController:self
     delegate:self];
}

/*
 自定义分享样式，可以自己构造分享列表页面
 
 */
- (IBAction)showShareList3:(id)sender {
    UIActionSheet *editActionSheet =
    [[UIActionSheet alloc] initWithTitle:@"图文分享"
                                delegate:self
                       cancelButtonTitle:nil
                  destructiveButtonTitle:nil
                       otherButtonTitles:nil];
    for (NSString *snsName in
         [UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray) {
        UMSocialSnsPlatform *snsPlatform =
        [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
        [editActionSheet addButtonWithTitle:snsPlatform.displayName];
    }
    [editActionSheet addButtonWithTitle:@"取消"];
    editActionSheet.tag = kTagShareEdit;
    [editActionSheet showFromTabBar:self.tabBarController.tabBar];
    editActionSheet.delegate = self;
}

- (IBAction)showShareList4:(id)sender {
    UIActionSheet *editActionSheet =
    [[UIActionSheet alloc] initWithTitle:@"直接分享到微博"
                                delegate:self
                       cancelButtonTitle:nil
                  destructiveButtonTitle:nil
                       otherButtonTitles:nil];
    for (NSString *snsName in
         [UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray) {
        UMSocialSnsPlatform *snsPlatform =
        [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
        [editActionSheet addButtonWithTitle:snsPlatform.displayName];
    }
    [editActionSheet addButtonWithTitle:@"取消"];
    editActionSheet.tag = kTagSharePost;
    editActionSheet.cancelButtonIndex = editActionSheet.numberOfButtons - 1;
    [editActionSheet showFromTabBar:self.tabBarController.tabBar];
    editActionSheet.delegate = self;
}

/*
 在自定义分享样式中，根据点击不同的点击来处理不同的的动作
 
 */
- (void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex + 1 >= actionSheet.numberOfButtons) {
        return;
    }
    
    //分享编辑页面的接口,snsName可以换成你想要的任意平台，例如UMShareToSina,UMShareToWechatTimeline
    NSString *snsName =
    [[UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray
     objectAtIndex:buttonIndex];
    NSString *shareText = @"友" @"盟" @"社" @"会"
    @"化组件可以让移动应用快速具备社会化分享、登录、"
    @"评" @"论" @"、"
    @"喜欢等功能，并提供实时、全面的社会化数据统计分"
    @"析服务。 http://www.umeng.com/social";
    UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];
    
    if (actionSheet.tag == kTagShareEdit) {
        //设置分享内容，和回调对象
        [[UMSocialControllerService defaultControllerService]
         setShareText:shareText
         shareImage:shareImage
         socialUIDelegate:self];
        UMSocialSnsPlatform *snsPlatform =
        [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
        snsPlatform.snsClickHandler(
                                    self, [UMSocialControllerService defaultControllerService], YES);
    } else if (actionSheet.tag == kTagSharePost) {
        [[UMSocialDataService defaultDataService]
         postSNSWithTypes:@[ snsName ]
         content:shareText
         image:shareImage
         location:nil
         urlResource:nil
         presentedController:self
         completion:^(UMSocialResponseEntity *response) {
             if (response.responseCode == UMSResponseCodeSuccess) {
                 UIAlertView *alertView =
                 [[UIAlertView alloc] initWithTitle:@"成功"
                                            message:@"分享成功"
                                           delegate:nil
                                  cancelButtonTitle:@"好"
                                  otherButtonTitles:nil];
                 [alertView show];
             } else if (response.responseCode !=
                        UMSResponseCodeCancel) {
                 UIAlertView *alertView =
                 [[UIAlertView alloc] initWithTitle:@"失败"
                                            message:@"分享失败"
                                           delegate:nil
                                  cancelButtonTitle:@"好"
                                  otherButtonTitles:nil];
                 [alertView show];
             }
         }];
    }
}

- (IBAction)login:(id)sender {
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:@"yunda" forKey:@"type"];
    [param setObject:@"3100074176480" forKey:@"postid"];
    
    [[RTHttpClient defaultClient]
     requestWithPath:[[APIConfig defaultConfig] getAPIURL:API_LOGIN]
     method:RTHttpRequestGet
     parameters:param
     prepareExecute:^{}
     
     success:^(NSURLSessionDataTask *task, id responseObject) {
         //         NSLog(@"response: %@", responseObject);
         
     }
     
     failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
}
- (IBAction)crash:(id)sender {
    NSArray *array = [NSArray new];
    [array lastObject];
}

@end
