//
//  AMPublicConfig.h
//  AMen
//
//  Created by gaoxinfei on 15/7/27.
//  Copyright (c) 2015年 gaoxinfei. All rights reserved.
//

#ifndef AMen_AMPublicConfig_h
#define AMen_AMPublicConfig_h


/*!
 @enum AMConversationType 会话类型
 */
typedef NS_ENUM(NSUInteger, AMConversationType) {
    /**
     * 私聊
     */
    AMConversationType_PRIVATE = 1,
    /**
     * 讨论组
     */
     AMConversationType_DISCUSSION,
    /**
     * 群组
     */
     AMConversationType_GROUP,
    /**
     * 聊天室
     */
    AMConversationType_CHATROOM,
    /**
     *  客服消息
     */
    AMConversationType_CUSTOMERSERVICE,
    /**
     *  系统消息
     */
    AMConversationType_SYSTEM,
    /**
     *  订阅号 Custom
     */
    AMConversationType_APPSERVICE, // 7
    
    /**
     *  订阅号 Public
     */
    AMConversationType_PUBLICSERVICE
};
/**
 *  AMConversationModelType
 */
typedef NS_ENUM(NSUInteger, AMConversationModelType) {
    /**
     *  AM_CONVERSATION_MODEL_TYPE_NORMAL
     */
    AM_CONVERSATION_MODEL_TYPE_NORMAL = 1,
    /**
     *  AM_CONVERSATION_MODEL_TYPE_COLLECTION
     */
    AM_CONVERSATION_MODEL_TYPE_COLLECTION = 2,
    /**
     *  AM_CONVERSATION_MODEL_TYPE_CUSTOMIZATION
     */
    AM_CONVERSATION_MODEL_TYPE_CUSTOMIZATION = 3,
    /**
     *  AM_CONVERSATION_MODEL_TYPE_PUBLIC_SERVICE
     */
    AM_CONVERSATION_MODEL_TYPE_PUBLIC_SERVICE = 4,
};

//消息的类别
typedef NS_ENUM(NSUInteger, AMMessageType){
    AM_TEXTMESSAGE = 1,
    AM_VOICEMESSAGE =2,
    AM_IMAGEMESSAGE = 3,
    AM_RICHCONTENTMESSAGE =4,
    AM_LOCATIONMESSAGE =5,
    AM_INFORMATIONNOTIFICATIONMESSAGE=6,
    AM_CONTACTNOTIFICATIONMESSAGE =7,
    AM_PROFILENOTIFICATIONMESSAGE=8,
    AM_COMMANDNOTIFICATIONMESSAGE =9,
    AM_USERMESSAGE=10,
    
    AM_BIBLE = 11, //经文分享
};

/*!
 @enum RCReceivedStatus 消息阅读状态
 */
typedef NS_ENUM(NSUInteger, AMReceivedStatus) {
    /**
     * 未读。
     */
    AMReceivedStatus_UNREAD = 0,
    /**
     * 已读。
     */
    AMReceivedStatus_READ = 1,
    /**
     * 未读。
     */
    AMReceivedStatus_LISTENED = 2,
    
    /**
     已下载
     */
    AMReceivedStatus_DOWNLOADED = 4,
    
};
/**
 * @enum RCSentStatus 发送出的消息的状态。
 */
typedef NS_ENUM(NSUInteger, AMSentStatus) {
    /**
     * 发送中。
     */
    AMSentStatus_SENDING = 10,
    
    /**
     * 发送失败。
     */
     AMSentStatus_FAILED = 20,
    
    /**
     * 已发送。
     */
     AMSentStatus_SENT = 30,
    
    /**
     * 对方已接收。
     */
     AMSentStatus_RECEIVED = 40,
    
    /**
     * 对方已读。
     */
     AMSentStatus_READ = 50,
    
    /**
     * 对方已销毁。
     */
     AMSentStatus_DESTROYED = 60
};

typedef NS_ENUM(NSInteger, AMMessageFrom) {
    AMMessageFromMe    = 0,   // 自己发的
    AMMessageFromOther = 1    // 别人发得
};

/**
 *  @enum 消息方向枚举。
 */
typedef NS_ENUM(NSUInteger, AMMessageDirection) {
    /**
     * 发送
     */
     // false
    
    /**
     * 接收
     */
    
    
    AMMessageDirection_SEND=1,
    AMMessageDirection_RECEIVE 
};

typedef NS_ENUM(NSUInteger, AMEnterMainViewControllerType){
    AM_NORMAL_ENTER=0,
    AM_QQ_ENTER =1,
    AM_WeChat_ENTER=2,
    AM_OPENSCREEN=3,
    AM_LANDING=4,
    AM_USERINFOENTER=5,
    AM_LOGIN=6,
    AM_AUTOLAND
    
};
/**
 *  @enum 媒体文件类型枚举。
 */
typedef NS_ENUM(NSUInteger, AMMediaType) {
    /**
     * 图片。
     */
    AM_MediaType_IMAGE = 1,
    
    /**
     * 声音。
     */
    AM_MediaType_AUDIO,
    
    /**
     * 视频。
     */
    AM_MediaType_VIDEO,
    
    /**
     * 通用文件。
     */
    AM_MediaType_FILE = 100
};

typedef NS_ENUM(NSUInteger, AM_EnterSelectFriendContr){
    AM_MessageEnterSelectFriendController=1,
    AM_AddressEnterSelectFriendControlller
};
//提示警告框的提示顺序
typedef NS_ENUM(NSUInteger, AM_AlertType) {
    /**
     * 手机号提示。
     */
    AM_PhoneAlert = 1,
    
    /**
     * 密码提示。
     */
    AM_PasswordAlert,
    
    /**
     * 验证码提示。
     */
    AM_ShortCodeAlert,
    
    /**
     * 网络请求提示。
     */
    AM_NetWorkAlert,
    
    /**
     * 网络请求提示。
     */
    AM_CountryAlert,
    
    AM_LaHeiAlert,
    
    AM_DeleteFrendsAlert,
    
    AM_SelectPictureAlert
    
};
//提示手机号校验提示
typedef NS_ENUM(NSUInteger, AM_CheckPhone) {

    AM_Phone_IsEmpty = 1,
    

    AM_Phone_IsFormat,
    

    AM_Phone_IsLength,
    
    AM_Phone_IsRight
};
//提示密码校验
typedef NS_ENUM(NSUInteger, AM_CheckPassword) {
    
    AM_Password_IsEmpty = 1,
    
    
    AM_Password_Greater30,
    
    
    AM_Password_Smaller6,
    

    AM_Password_IsRight,
    
    
    AM_Password_Format,
    
    AM_Password_Empty
};

typedef NS_ENUM(NSInteger, AM_FRIENDS_RELATION) {
    AM_Friends_All    = 0,
    AM_Friends_Simple = 1,
    AM_Friends_Black,
    AM_Friends_FengHao
};

typedef NS_ENUM(NSInteger, AM_ENTER_USERINFO) {
    AM_ThirdPlatform    = 0,
    AM_UserInfoController = 1,
    AM_CHAT=2,
    AM_ReportUser=3,
    AM_ME = 4
};
typedef NS_ENUM(NSInteger, AM_PLATFORM) {
    AM_QQ_LAND    = 0,
    AM_WECHAT_LAND = 1,
};

typedef NS_ENUM(NSInteger, AM_MODIFYNAME_TYPE) {
    AM_USER_NAME    = 0,
    AM_GROUP_NAME = 1,
};


#endif


#define AM_APP_LANGUAGE           @"zh"
#define AM_APP_VERSION            @"20130306"
#define AM_APP_BUNDLEID           @"com.xxx.xxxx"
#define AM_SYSTEM_IDFA            @""
#define AM_SYSTEM_DEVICE          @""
#define AM_SYSTEM_OSVER           @"IOS"
#define AM_SYSTEM_LANGUAGE        @"zh"

#define AM_HPPT_VERSION           @"100"


#define AM_OPENSCREEN_TIME         2000
#define AM_OPENSCREEN_CONTENT             @"兄弟姐妹的家园"
#define AM_SERVICE_ID  1000       //客服ID

#define NSUSERDEFAULIT             [NSUserDefaults standardUserDefaults]

//融云收到新的消息
#define AM_NOTIFICATION_NEW_RC_MESSAGE     @"AMNewRCMessageNotification"
//新增一个会话（用于会话页面）
#define AM_NOTIFICATION_NEW_CONVERSATION  @"AMNewConversationNotification"
//新增一个聊天消息（用于聊天页面）
#define AM_NOTIFICATION_NEW_AM_MESSAGE    @"AMNewAMMessageNotification"
//聊天窗口打开
#define AM_NOTIFICATION_CHAT_OPEN         @"AMChatOpenNotification"
//聊天窗口关闭
#define AM_NOTIFICATION_CHAT_CLOSED       @"AMChatClosedNotification"
//聊天页面发送了一条新的消息，更新会话
#define AM_NOTIFICATION_NEW_LOCAL_MESSAGE   @"AMNewLocalMessageNotification"
//刷新token
#define AM_NOTIFICATION_INVALID_TOKEN @"AMInvalidTokenNotification"
//更新通讯录群列表
#define AM_NOTIFICATION_REFRESH_GROUP_INCONTACT @"AMRefreshGroupInContactNotification"
/*
 * 位置信息
 */
#define LOCATION_city @"location_city"
#define LOCATION_address @"location_address"
#define LOCATION_longitude @"location_longitude"
#define LOCATION_latitude @"location_latitude"


//网络变化
#define AM_NETWORK_CHANGE          @"AMNetWorkChange"
//新的好友申请
#define AM_NOTIFICATION_NEW_FRIEND_REQUEST  @"AMNewFriendRequestNotication"
//重置好友申请未读状态
#define AM_NOTIFICATION_RESET_FRIEND_REQUEST @"AMResetFriendRequestNotification"
//群组被删除
#define AM_NOTIFICATION_GROUP_REMOVED @"AMGroupRemovedNotification"
//用户的好友关系变更
#define AM_NOTIFICATION_FRIENDS_CHANGE @"AMFriendsChangeNotification"
//群组保存在通讯录设置
#define AM_NOTIFICATION_GROUP_INCONTACT_CHANGE @"AMGroupInContactChangeNotification"
//群组是否显示群成员名称
#define AM_NOTIFICATION_GROUP_SHOWNAME_CHANGE @"AMGroupShowNameChangeNotification"
//将指定会话未读消息数目清零
#define AM_NOTIFICATION_RESET_UNREAD @"AMResetUnreadStatusNotification"
//移除指定会话
#define AM_NOTIFICATION_REMOVE_CONVERSATION @"AMRemoveConversationNotification"


//更新会话列表中群组信息
#define AM_NOTIFICATION_UPDATE_GROUPINFO @"AMUpdateGroupInfoNotification"

#define AM_IS_LAND                @"isLand"//登录状态
#define AM_IS_FIRST_LOGIN         @"isFirstLogin"//首次登录，需要完善个人信息
//#define AM_QQ_FIRST_REG           @"QQfirstReg"
//#define AM_WECHAT_FIRST_REG       @"WeChatfirstReg"
#define AM_LOCATION_UPDATE        @"location"
//#define AM_FIRST_START            @"firstStart"



#define AM_USERINFO               @"UserInfoModel"

#define AM_USER_IM_TOKEN          @"IM_TOKEN"
#define AM_USER_ACCOUNTID         @"UserId"

#define AM_GROUPS_DB              @"GroupList"
#define AM_USER_BIND_PHONE        @"UserBindPhone"
#define AM_MESSAGE_LIST           @"MessageList"

//QQ SDK中Key值
#define AM_QQ_Key                @"ASJIYRxo7CfkLPy9"
#define AM_QQ_APPID              @"1104784484"
//微信平台的信息
#define AM_WXAPP_ID              @"wxb3509f0204b8d3cb"
#define AM_WXAPP_SECRET          @"457fdf85cd950d433626fec52f9c610d"
//融云平台信息
#define AM_RONGCLOUD_APP_KEY     @"cpj2xarlj5z4n"
#define AM_RONGCLOUD_APP_SECRET  @"EDfWktm6IVEc"
//友盟平台
#define AM_UMENG_KEY             @"56318e6c67e58e2ebb000413"



//聊天类型定义
#define AM_PRIVATECHAT                @"privateChat"
#define AM_GROUPCHAT                  @"groupChat"
#define AM_SYSTEMNOTICE               @"systemNotice"
#define AM_PUBLICSERVICE              @"publicService"


//头像
#define AM_USER_AVATAR  @"user_default_avatar"
#define AM_GROUP_AVATAR @"group_default_avatar"

#define  NavightBarHeight        64

#define  FRAME_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define  FRAME_WIDTH    [UIScreen mainScreen].bounds.size.width

#define  AM_WIDTH_RATIO          FRAME_WIDTH/375.0
#define  AM_HEIGHT_RATIO         FRAME_HEIGHT/667.0



//#define  TABBARHEITHT               self.tabBarController.tabBar.frame.size.height
#define  TABBARHEITHT              50*FRAME_HEIGHT/667.0
#pragma mark -聊天界面
//工具栏
#define inputBarContrHeigtht    50
//表情栏
#define emojiBoardViewHeight    220
//扩展栏
#define boardViewHeight         190

#define iPhone6Pus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


#define ServerJieKu     1
//#define ServerJieKu     0


typedef NS_ENUM(NSInteger, MD_ENTER_USERINFO) {
    MD_Disciple    = 0,  //我的徒弟
    MD_DiscipleUp = 1,  //徒弟进贡
    MD_DepositT=2,      //提现
    MD_Ranking=3     //转客排行
};

typedef NS_ENUM(NSUInteger, MD_EnterWebControl){
    MD_AboutController=1,
    MD_ProtocolControlller = 2
};

typedef NS_ENUM(NSInteger, MD_Request_Type) {
    MD_Rec    = 0,
    MD_News = 1,
    MD_Smile=2,
    MD_Life=3,
    MD_Mother=4,
    MD_Entertainment = 5,
    MD_Curious = 6,
    MD_Finance = 7,
    MD_Technology = 8,
    MD_Delicious =  9,
    MD_Encourage =  10,
    MD_Encyclopedias = 11,
    MD_Car =12,
    MD_Fashion = 13,
    MD_Military = 14,
    MD_Tour = 15
};



