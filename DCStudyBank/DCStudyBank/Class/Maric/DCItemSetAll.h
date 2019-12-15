
//
//  DCItemSetAll.h
//  ItemBank
//
//  Created by mac on 2019/11/24.
//  Copyright © 2019 mac. All rights reserved.
//

#ifndef DCItemSetAll_h
#define DCItemSetAll_h

#define ApplicationKeyWindow [UIApplication sharedApplication].keyWindow

#define weakSelf(myself) __weak typeof(myself) weakSelf = myself;
///适配屏幕
#define AutoScreen(x)  ((x) * (XYScreen_Width / 375.0))
#define AutoScreenH(h)  (h* XYScreen_Width / 375.0)
///字体
#define XYFont(x) [UIFont systemFontOfSize:x]
#define XYBFont(x) [UIFont boldSystemFontOfSize:x]

///根据RGB生成颜色
#define RGB(R,G,B) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1]
#define RGBAColor(R,G,B,A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]
///根据HexString生成颜色
#define  XYColorHexString(hexString) [UIColor colorWithHexString:hexString]

#define IOS11            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 11.0)
#define KScreenWidth                              [UIScreen mainScreen].bounds.size.width
#define KScreenHeight                             [UIScreen mainScreen].bounds.size.height
#define UISreenWidthScale   UIScreenWidth / 320

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)
#define IS_IPhoneX [[UIScreen mainScreen] bounds].size.height >= 812

//****************颜色设置*////////////
#define KMainBgColor [UIColor colorWithHexString:@"#ffffff"]
#define KMainColor   [UIColor colorWithHexString:@"#00C0AE"] //主题色
#define kNavigationTitleBgColor [UIColor colorWithHexString:@"#222222"]
#define kGobalViewBgColor [UIColor colorWithHexString:@"#ffffff"]
#define kMainTitleColor [UIColor colorWithHexString:@"#222222"]
#define KTableListBGColor [UIColor colorWithHexString:@"#F7F8FA"]
#define kTableViewCellSpColor [UIColor colorWithHexString:@"#E8E8E8"]
#define KTextColor [UIColor colorWithHexString:@"#999999"]

//************字体大小***/
#define KFont(X) [UIFont systemFontOfSize:X];


//*******/////*********网络相关*******************
#define ServerAddressURL @"http://106.12.138.244:8080/"

#define NetworkingIsLoadingDescription  @"网络请求中"
//网络异常
#define NetworkingErrorDescription  @"网络异常啦，请您尝试刷新 ~~"
//数据异常
#define NetworkingDataErrorDescription  @"出错啦，请您尝试刷新 ~~"
//注册获取短信验证码
#define GetPhoneCodePath @"user/registry"
 //注册
#define RegisterPath @"user/verify/"
//登录
#define LogInPath @"user/login/"
//忘记密码获取验证码
#define ForgetPasswordPhoneCodePath @"user/reset/"
//重置密码
#define AgainSetPasswordPath @"user/setPwd/"
//获取首页进度
#define HomeStudyProgressPath @"course/queryLianXiJDByCorid/"
//首页获取科目
#define HomeStudyCategoryPath @"user/token/synthesize/"
//修改密码
#define SetPasswordPath @"user/token/updatePwd/"
//参加考试
#define JoinStudySubPath @"subject/queryOneAndTwo/"
//保存选择的考试
#define SavJoinSubjectPath @"user/token/homeKeMu/"
//科目管理
#define StudySubjectMangerPath @"subject/querySubInfoKM/"
//科目管理保存
#define SaveStudyJectMangerPath @"user/token/trigger/"
//上传头像
#define UpateUserHeaderIconPath @"user/token/upload/"
//修改个人资料
#define SetUserInfoPath @"user/token/update/"
//报考地区
#define BaoKaoAddressPath @"user/token/updateDQ/"
//首页考试进度
#define GetUserSecorePath @"course/queryLianXiJDByCorid/"
//智能考点练习
#define KaoDianTestPath @"itemController/queryItemList/"
//新增试题收藏
#define AddCollectPath @"collectController/deleteCollect/"
//取消收藏
#define DeleteCollectPath @"collectController/deleteCollect/"
//真题模考
#define ZTMoKaoListPath @"itemController/queryMZ"
//章节练习
#define ZHangJiePath @"itemController/queryItemList"
//保存用户****************卢金
#define UserHeaderIconPlaceholderImage [UIImage imageNamed:@"my_head_icon"]
///保存用户登录数据路径
#define UserLoginPatch @"LastUserLoginKey"
#define LastLoginUserAccount @"LastLoginAccount"
#define LastLoginUserPSW @"LastLoginPSW"
#define LastLoginUserID @"LastLoginUserID"
#endif /* DCItemSetAll_h */
