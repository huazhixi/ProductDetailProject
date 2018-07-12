//
//  NSString+HXExtension.h
//  600s
//
//  Created by Lingxiu on 16/7/29.
//  Copyright © 2016年 Huazhi_xi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (HXExtension)

+ (NSString *)changeToWanString:(float)floatNum;

+ (NSString *)changeTimeStampToChinaTime:(NSString *)timeStampStr;

+ (NSString*)changeTelephone:(NSString*)teleStr;
/**
 根据文字计算宽度

 @param string 文字
 @param height 高度
 @param font 文字大小
 @return 返回的宽度
 */
+ (CGFloat)calculateRowWidth:(NSString *)string withHeight:(NSInteger)height font:(NSInteger)font;

/************************            验证相关               ************************/
//验证银行卡
+ (BOOL) IsBankCard:(NSString *)cardNumber;
//验证身份证
+ (BOOL) IsIdentityCard:(NSString *)IDCardNumber;
//验证邮箱
+ (BOOL) IsEmailAdress:(NSString *)Email;
// 验证手机号
+ (BOOL) IsPhoneNumber:(NSString *)number;


/************************            时间转换                  ************************/

//获取当前时间戳  （以毫秒为单位）
+(NSString *)getNowTimeTimes;
//获取N天前的时间戳  （以毫秒为单位）
+(NSString *)getNDaysTimes:(NSInteger)n;

//获取N天后的时间戳  （以毫秒为单位）
+(NSString *)baseTime:(NSInteger)baseTime afterDays:(NSInteger)n;

+ (NSString *)changeHTMLText:(NSString *)bbsContent;

+ (NSString *)dateToTimeData:(NSString *)dataString;
/**
 计算年龄

 @param bornString 出生年月日
 @return 当前年龄
 */
+(NSString *)dateToAge:(NSString *)bornString;
/**
 *  时间戳转正常格式时间
 *
 *  @param timeStampStr 时间戳
 *
 *  @return 正常时间
 */
+ (NSString *)changeTimeStampToTime:(NSString *)timeStampStr;
/**
 *  时间戳转正常格式时间 只有 年月日 的格式
 *
 *  @param timeStampStr 时间戳
 *
 *  @return 正常时间
 */
+ (NSString *)changeTimeStampToYMDTime:(NSString *)timeStampStr;
/**
 *  时间戳转正常格式时间 只有 年月 的格式
 *
 *  @param timeStampStr 时间戳
 *
 *  @return 正常时间
 */
+ (NSString *)changeTimeStampToYMTime:(NSString *)timeStampStr;
/**
 根据当前日期获取时间戳
 */
+(NSString *)getNowTimeTimeStamp;
/**
 *  手机号码中间是****
 *
 *  @param normalString 传入的手机号码
 *
 *  @return 返回带****的手机号码
 */
+ (NSString *)changeToEncryptStringWithNormalString:(NSString *)normalString;

/**
 根据当前日期计算星期几

 @param inputDateString 系统当前时间
 @return 星期
 */
+ (NSString*)weekdayStringFromDate:(NSString *)inputDateString;

/**
 实现几天前，几小时前，几分钟前

 @param string yyyy-MM-dd HH:mm:ss.SSS
 @return 几天前，几小时前，几分钟前
 */
+ (NSString *) compareCurrentTime:(NSString *)string;

/**
 带emoji的文本编码

 @param normalString 普通文本
 */
+ (NSString *)emojiCode:(NSString *)normalString;

/**
 emoji反编码

 @param codeString 带emoji的文本
 */
+ (NSString *)emojiEncode:(NSString *)codeString;

/**
 判断字符串中是否含有emoji表情

 @param string 传入字符串
 @return 返回布尔值
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;
@end
