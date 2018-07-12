

#ifndef Constant_h
#define Constant_h

/*
    //举例
    //是否是第一次进入程序
    static NSString *const USERDEFAULT_FIRST_ENTER = @"USERDEFAULT_FIRST_ENTER"; // ⚠️变量名称全部大写，多个单词用下划线分隔
 */

#pragma mark - ---------- 偏好设置（Userdefault）----------


#pragma mark - ---------- 解归档（Archive）----------


#pragma mark - ---------- 通知（Notification）----------
//宝贝详情滑动
static NSString *const NOTIFICATION_BABYDEAILTY_SCROLL = @"NOTIFICATION_BABYDEAILTY_SCROLL";
// 转让商品数据
static NSString *const Notification_Transfer_Info = @"Notification_Transfer_Info";
// 支付成功消息
static NSString *const Notification_PaySuccess_MSG = @"Notification_PaySuccess_MSG";
// 强制更新通知
static NSString * const kNotificationAppShouldUpdate = @"appShouldUpdate";



#pragma mark - ---------- 颜色 (Color) ----------

#define RGB0X(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

///常用颜色
#define black_color     [UIColor blackColor]
#define blue_color      [UIColor blueColor]
#define brown_color     [UIColor brownColor]
#define clear_color     [UIColor clearColor]
#define darkGray_color  [UIColor darkGrayColor]
#define darkText_color  [UIColor darkTextColor]
#define white_color     [UIColor whiteColor]
#define yellow_color    [UIColor yellowColor]
#define red_color       [UIColor redColor]
#define orange_color    [UIColor orangeColor]
#define purple_color    [UIColor purpleColor]
#define lightText_color [UIColor lightTextColor]
#define lightGray_color [UIColor lightGrayColor]
#define green_color     [UIColor greenColor]
#define gray_color      [UIColor grayColor]
#define magenta_color   [UIColor magentaColor]

// 主题红色
#define kMAIN_RED_COLOR UIColorFromRGB(0xf50014)
//项目主题黄颜色
#define kMAIN_YELLOW_COLOR    RGB0X(0Xffaa00)
//项目主题绿颜色
#define kMAIN_GREEN_COLOR    RGB0X(0X48b32f)
//项目重要文字颜色
#define MAIN_TEXT_COLOR    RGB0X(0X333333)
//项目段落文字颜色
#define NORMAL_TEXT_COLOR    RGB0X(0X666666)
//项目评论文字颜色
#define FUZHU_COLOR    RGB0X(0X999999)
//项目未选中颜色
#define NOT_CHOOSE_COLOR    RGB0X(0Xcccccc)
//项目提示性文字颜色
#define TISHI_COLOR    RGB0X(0Xe5e5e5)
//项目线和背景颜色
#define LINE_BACK_COLOR    RGB0X(0Xf4f4f4)
//项目线和背景颜色
#define TABLE_BACK_COLOR    RGB0X(0Xf4f4f4)
//按钮 borderColor
#define BUTTON_BORDER_COLOR    RGB0X(0Xdcdcdc)

// RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#pragma mark - ---------- 字体(Font) ----------

///正常字体
#define H30 [UIFont systemFontOfSize:30]
#define H29 [UIFont systemFontOfSize:29]
#define H28 [UIFont systemFontOfSize:28]
#define H27 [UIFont systemFontOfSize:27]
#define H26 [UIFont systemFontOfSize:26]
#define H25 [UIFont systemFontOfSize:25]
#define H24 [UIFont systemFontOfSize:24]
#define H23 [UIFont systemFontOfSize:23]
#define H22 [UIFont systemFontOfSize:22]
#define H20 [UIFont systemFontOfSize:20]
#define H19 [UIFont systemFontOfSize:19]
#define H18 [UIFont systemFontOfSize:18]
#define H17 [UIFont systemFontOfSize:17]
#define H16 [UIFont systemFontOfSize:16]
#define H15 [UIFont systemFontOfSize:15]
#define H14 [UIFont systemFontOfSize:14]
#define H13 [UIFont systemFontOfSize:13]
#define H12 [UIFont systemFontOfSize:12]
#define H11 [UIFont systemFontOfSize:11]
#define H10 [UIFont systemFontOfSize:10]
#define H8 [UIFont systemFontOfSize:8]

#pragma mark - ---------- 其他（Others） ----------

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角加阴影
#define ViewRadiusAndShadow(View, Radius, Color)\
\
[View.layer setShadowColor:[Color CGColor]];\
[View.layer setShadowOffset:CGSizeMake(0, 3)];\
[View.layer setShadowOpacity:0.3];\
[View.layer setShadowRadius:3.0];\
[View.layer setCornerRadius:(Radius)];\

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]


#define V_IMAGE(imgName) [UIImage imageNamed:imgName]
#define URL(url) [NSURL URLWithString:url]
#define string(str1,str2) [NSString stringWithFormat:@"%@%@",str1,str2]
#define s_str(str1) [NSString stringWithFormat:@"%@",str1]
#define s_Num(num1) [NSString stringWithFormat:@"%d",num1]
#define s_Integer(num1) [NSString stringWithFormat:@"%ld",num1]


static NSString *const NET_NOT_WORK = @"网络断开连接，请检查网络";

//static NSString *const ERROR_MESSAGE = @"网络请求失败";
static NSString *const ERROR_MESSAGE = @"服务器请求失败...";


#pragma mark ------------- 常量（const）-----------------

/** 常量数 */
//CGFloat const TCMargin = 10;

///** 导航栏高度 */
//CGFloat const TCNaviH = 44;
//
///** 底部tab高度 */
//CGFloat const TCBottomTabH = 49;
///** 顶部Nav高度+指示器 */
//CGFloat const TCTopNavH = 64;

#endif /* ProjectCommon_h */
