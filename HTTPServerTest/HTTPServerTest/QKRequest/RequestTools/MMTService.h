//
//  MMTService.h
//  Medicalmmt
//
//  Created by gulei on 16/2/23.
//  Copyright © 2016年 gulei. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^Success) (id responseObject);
typedef void (^Failure) (NSError *error);


#define kServerPre        1


@interface MMTService : NSObject

+ (id)shareInstance;

-(void)forgetWithmobile:(NSString *)mobile
               password:(NSString *)password
                   code:(NSString *)code
                success:(Success)success
                failure:(Failure)failure;//重置密码

-(void)loginWithmobile:(NSString *)mobile
              password:(NSString *)password
               success:(Success)success
               failure:(Failure)failure;

-(void)signUpWithrole:(NSString *)role
               mobile:(NSString *)mobile
             password:(NSString *)password
                 code:(NSString *)code
              success:(Success)success
              failure:(Failure)failure;
//刷新鉴权码
-(void)refreshTokenSuccess:(Success)success
                   failure:(Failure)failure;

//获取设备种类
-(void)getEquipmentTypeSuccess:(Success)success
                       failure:(Failure)failure;

//获取设备品牌
-(void)getEquipmentBrandWithTypeId:(NSString *)tid
                           Success:(Success)success
                           failure:(Failure)failure;

//获取设备型号
-(void)getEquipmentModelWithBrandid:(NSString *)bid
                            Success:(Success)success
                            failure:(Failure)failure;
//查询维修单
-(void)getUserOrdersSuccess:(Success)success
                    failure:(Failure)failure;

//查询部门（科室）
-(void)getGeneralDepartmentSuccess:(Success)success
                           failure:(Failure)failure;

/**
 *  提交维修单
 *
 *  @param engineerid       工程师ID
 *  @param equipmenttypeid  设备种类ID
 *  @param equipmentbrandid 设备品牌ID
 *  @param equipmentmodelid 设备型号ID
 *  @param departmentid     部门ID
 *  @param identifier       出厂号
 *  @param fault            故障描述
 *  @param success          success description
 *  @param failure          failure description
 */
-(void)postOrderWithEngineerid:(NSString *)engineerid
               equipmentTypeId:(NSString *)equipmenttypeid
              equipmentbrandid:(NSString *)equipmentbrandid
              equipmentmodelid:(NSString *)equipmentmodelid
                  departmentid:(NSString *)departmentid
                    identifier:(NSString *)identifier
                         fault:(NSString *)fault
                        images:(NSArray *)images
                       Success:(Success)success
                       failure:(Failure)failure;

//查询职务列表
-(void)getJobTitlesSuccess:(Success)success
                   failure:(Failure)failure;

//查询企业用户或工程师个人资料
-(void)getUserProfileWithUid:(NSString *)uid
                     Success:(Success)success
                     failure:(Failure)failure;

//更新企业用户或工程师个人资料
-(void)updateUserProfileWithMobile:(NSString *)mobile
                              name:(NSString *)name
                         id_number:(NSString *)idnumber
                          nickname:(NSString *)nickname
                           corp_id:(NSString *)corpid
                     department_id:(NSString *)dip
                       jobtitle_id:(NSString *)jobtitleid
                            gender:(NSString *)gender
                           address:(NSString *)address
                           Success:(Success)success
                           failure:(Failure)failure;

//搜索适合维修特定设备的工程师
-(void)searchEngineerWithEquipid:(NSString *)equipment_id
               Equipment_Type_id:(NSString *)equipment_type_id
                         keyword:(NSString *)keyword
                         Success:(Success)success
                         failure:(Failure)failure;

//发送短信验证码
-(void)sendCodeWithMobile:(NSString *)mobile
                     Type:(NSString *)type
                  Success:(Success)success
                  failure:(Failure)failure;
/**
 *  上传企业用户/工程师头像
 *
 *  @param imageData 	头像图片	Y	小于等于2MB
 *  @param success   success description
 *  @param failure   failure description
 */
-(void)setAvatarWithImageData:(NSData *)imageData
                      Success:(Success)success
                      failure:(Failure)failure;
//查询企业设备列表
- (void)getEquipmentsWithPage:(NSString *)page
                   Success:(Success)success
                   failure:(Failure)failure;
//维修单故障设备照片列表
- (void)getOrderPhotosWithId:(NSString *)order_id
                     Success:(Success)success
                     failure:(Failure)failure;

//设备照片列表
- (void)getEquipmentPhotosWithId:(NSString *)equipment_id
                         Success:(Success)success
                         failure:(Failure)failure;
//添加设备


//字段	含义	必传	备注
//equipment_type_id	    设备类别ID	Y
//equipment_brand_id	设备品牌ID	Y
//equipment_model_id	设备型号ID	Y
//identifier	        设备出厂号	Y
//department_id	        科室ID   	Y
//vender	            供应商	    N	100字以内
//service_line	        维修电话	    N	45字以内
//acceptance_date       验货日期	    N	unix时间戳
//install_date          安装日期	    N	unix时间戳
//warranty_end          质保到期日	N	unix时间戳
//warranty_range        维修范围   	N	200字以内
//contact               联系人    	N	45字以内
//memo                  备注	        N



- (void)addEquipmentWithTypeId:(NSString *) type
                       BrandId:(NSString *) brand
                       ModelId:(NSString *) model
                    Identifier:(NSString *) identifier
                 Department_id:(NSString *)department
                        Vender:(NSString *)vender
                  Service_line:(NSString *)service_line
               Acceptance_date:(NSString *)acceptance_date
                  Install_date:(NSString *)install_date
                  Warranty_end:(NSString *)warranty_end
                Warranty_range:(NSString *)warranty_range
                       Contact:(NSString *)contact
                          Memo:(NSString *)memo
                       Success:(Success)success
                       failure:(Failure)failure;

//派单
- (void)dispatchOrderWithOrderId:(NSString *)order_id
                      engineerId:(NSString *)engineer_id
                         Success:(Success)success
                         failure:(Failure)failure;


//更新维修单状态
- (void)updateOrderStatusWithId:(NSString *)order_id
                         status:(NSString *)status
                           memo:(NSString *)memo
                          fault:(NSString *)fault
                         images:(NSArray *)images
                         Succes:(Success)success
                        failure:(Failure)failure;




//获取 广告页

- (void)getAdListWithRole:(NSString *)role
                  Success:(Success)success
                  failure:(Failure)failure;

//查询维修单
- (void)getMaintainListWithPage:(NSString *)page
                         Status:(NSString *)status
                        success:(void (^)(NSArray *lists))success
                           fail:(void (^)(NSError *error))fail;


//查询关联用户
- (void)getRelatedListWithPage:(NSString *)page
                        success:(void (^)(NSArray *lists))success
                           fail:(void (^)(NSError *error))fail;



//- (void)updateOrderMsg:(NSString *)msg
//            WithImages:




- (void)updateEquipmentWithEquipmentId:(NSString *)equipmentId
                                TypeId:(NSString *) type
                               BrandId:(NSString *) brand
                               ModelId:(NSString *) model
                            Identifier:(NSString *) identifier
                         Department_id:(NSString *)department
                                Vender:(NSString *)vender
                          Service_line:(NSString *)service_line
                       Acceptance_date:(NSString *)acceptance_date
                          Install_date:(NSString *)install_date
                          Warranty_end:(NSString *)warranty_end
                        Warranty_range:(NSString *)warranty_range
                               Contact:(NSString *)contact
                                  Memo:(NSString *)memo
                               Success:(Success)success
                               failure:(Failure)failure;

- (void)getequipmentwithEquipment_Id:(NSString *)equipment_id
                      Success:(Success)success
                      failure:(Failure)failure;


-(void)getProfileWithUid:(NSString *)uid
                     Success:(Success)success
                     failure:(Failure)failure;


-(void)getUidWithPhone:(NSString *)phone
               Success:(Success)success
               failure:(Failure)failure;

-(NSDictionary *)syncgetProfileWithUid:(NSString *)uid;


- (void)getchatroomwithType:(NSString *)type
                  User_role:(NSString *)role
                    Keyword:(NSString *)keyword
                    Success:(Success)success
                    failure:(Failure)failure;


-(void)postProfileWithsex:(NSString *)sex
                birthday:(NSString *)birthday
               education:(NSString *)education
                vocation:(NSString *)vocation
                  income:(NSString *)income
                  images:(NSArray *)images
                 Success:(Success)success
                 failure:(Failure)failure;

- (NSDictionary *)syncgetAppCol;
- (NSDictionary *)syncgetArticleClassWith:(NSString *)mouduleId;
- (NSDictionary *)syncgetMyPageinfoWith:(NSString *)mouduleId;
- (NSDictionary *)syncgetStartAd;
-(void)postTicketWithcontent:(NSString *)content
                   images:(NSArray *)images
                  Success:(Success)success
                     failure:(Failure)failure;


//生成入参签名
-(NSString *)generateSignatureParams:(NSDictionary *)paramDic;






@end
