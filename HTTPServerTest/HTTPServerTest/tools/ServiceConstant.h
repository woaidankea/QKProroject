//
//  ServiceConstant.h
//  Medicalmmt
//
//  Created by gulei on 16/2/23.
//  Copyright © 2016年 gulei. All rights reserved.
//

#ifndef MMTService_HttpConstant_h
#define MMTService_HttpConstant_h
#define POST_VALUE(_VAL)  (_VAL)?(_VAL):@""
#define kTransferKey @"&jk!@#$%^&td2016"
//#define kServerUrl  @"http://192.168.1.4"

//#define kQXServerUrl            @"http://192.168.1.6"
#define kQXServerUrl            @"https://api.jieku.com/ios"

#define kGetUser                @"/User/GetUser"
#define kSystemConfig           @"/System/SetConfig"
#define kKeyState               @"/System/KeyState"

#define kGetMenu                @"/Index/GetMenu"           //获取首页信息
#define kGetUserBalance         @"/User/UserBalance"        //获取首页余额
#define kTaskStatus             @"/Task/TaskStatus"         //验证任务状态
#define kTudiList               @"/Tudi/TudiList"           //获取收徒链接
#define kTaskInfo               @"/Task/TaskInfo"           //获取任务信息
#define kIncomeList             @"/Income/IncomeList"       //收入明细
#define kAcceptTask             @"/Task/AcceptTask"         //用户接受任务
#define kTaskList               @"/Task/TaskList"           //任务列表
#define kUserInfo               @"/User/UserInfo"           //用户基本资料
#define kPhoneBdUser            @"/Phone/BdUser"            //用户绑定手机号码操作
#define kPhoneGetCode           @"/Phone/GetCode"           //手机绑定获取验证码
#define kStLink                 @"/Stu/StLink"              //获取收徒链接
#define kupUserInfo           @"/User/upUserInfo"           //更新用户信息
#define kCashApplyAl           @"/Cash/CashApplyAli"           //申请提现阿里
#define kCashApplyPhone          @"/Cash/CashApplyPhone"           //手机充值
#define kGiveupTask            @"/Task/GiveUpTask"          //放弃任务
#define kCopyString            @"/keyServices/copy.string"          //复制关键词
#define kAutoBack               @"/keyServices/autoback"    //自动返回主页
#define kChengji                @"/Income/ChengJi"

#define kQhCode                @"/Switch/QhGetCode"   //切换验证码
#define kswitchUser             @"/Switch/switchuser"    //切换用户

#define kAppInfo             @"/keyServices/app.getInfo"    //判断是否安装应用
#define kAppOpen             @"/keyServices/app.openApp"    //判断是否安装应用

#define kidBDMobile          @"/user/isbdmobile"

#define kidBDWechat          @"/user/isbdwechat"



#define kGetHeader              @"/getheader.php"



#endif
