//
//  LoginViewController.h
//  RTLibrary-ios
//
//  Created by Ryan on 14-8-3.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "BaseViewController.h"
#import "UMSocialControllerService.h"
#import "UMSocialShakeService.h"
@interface LoginViewController
: BaseViewController<UIActionSheetDelegate, UMSocialUIDelegate,
UMSocialShakeDelegate>
@property(weak, nonatomic) IBOutlet UILabel *m_versionLbl;

@end
