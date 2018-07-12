//
//  NSString+HXExtension.m
//  600s
//
//  Created by Lingxiu on 16/7/29.
//  Copyright © 2016年 Huazhi_xi. All rights reserved.
//

#import "NSString+HXExtension.h"

@implementation NSString (HXExtension)

+ (NSString *)changeToWanString:(float)floatNum {
    if (floatNum > 10000) {
        return [NSString stringWithFormat:@"%.2f万", floatNum / 10000];
    } else {
        return [NSString stringWithFormat:@"%.2f", floatNum];
    }
}
+ (NSString*)changeTelephone:(NSString*)teleStr {
    NSString *string = [teleStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return string;
}

+ (CGFloat)calculateRowWidth:(NSString *)string withHeight:(NSInteger)height font:(NSInteger)font {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, height)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}

+ (BOOL) IsBankCard:(NSString *)cardNumber
{
    if(cardNumber.length==0)
    {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++)
    {
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

+ (BOOL) IsIdentityCard:(NSString *)IDCardNumber
{
    if (IDCardNumber.length <= 0) {
        return NO;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:IDCardNumber];
}

+ (BOOL) IsEmailAdress:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}

+ (BOOL) IsPhoneNumber:(NSString *)number
{
    NSString *phoneRegex1=@"1[34578]([0-9]){9}";
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
    return  [phoneTest1 evaluateWithObject:number];
}

//获取当前时间戳  （以毫秒为单位）
+(NSString *)getNowTimeTimes {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    return timeSp;
}

//获取当前时间戳  （以毫秒为单位）
+(NSString *)getNDaysTimes:(NSInteger)n {
    NSDate*nowDate = [NSDate date];
    NSDate* theDate;
    if(n!=0){
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        theDate = [nowDate initWithTimeIntervalSinceNow: oneDay*n ];//initWithTimeIntervalSinceNow是从现在往前后推的秒数
    }else{
        theDate = nowDate;
    }
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *the_date_str = [date_formatter stringFromDate:theDate];
    
    NSString *string = [NSString stringWithFormat:@"%@ 23:59:00 000", the_date_str];
    // 日期格式化类
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // 设置日期格式 为了转换成功
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss SSS";
    // NSString * -> NSDate *
    NSDate *data = [format dateFromString:string];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[data timeIntervalSince1970]*1000];
    return timeSp;
}
//获取N天后的时间戳  （以毫秒为单位）
+(NSString *)baseTime:(NSInteger)baseTime afterDays:(NSInteger)n {
    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
    
    NSDate *baseDate = [NSDate dateWithTimeIntervalSince1970:baseTime];
    NSTimeInterval interval = oneDay * n;
    
    NSDate *afterDate = [NSDate dateWithTimeInterval:interval sinceDate:baseDate];

    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *the_date_str = [date_formatter stringFromDate:afterDate];
    
//    NSString *string = [NSString stringWithFormat:@"%@ 23:59:00 000", the_date_str];
//    // 日期格式化类
//    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//    // 设置日期格式 为了转换成功
//    format.dateFormat = @"yyyy-MM-dd HH:mm:ss SSS";
//    // NSString * -> NSDate *
//    NSDate *data = [format dateFromString:string];
//    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[data timeIntervalSince1970]*1000];
    return the_date_str;
}
+ (NSString *)changeHTMLText:(NSString *)bbsContent {
    
    NSRange range = [bbsContent rangeOfString:@"font-size:"];
    if (range.location == NSNotFound) {
        NSLog(@"can not change fontsize!");
    } else {
        NSArray*sourcearray = [bbsContent componentsSeparatedByString:@"font-size:"];
        NSMutableArray *bigArray = [NSMutableArray arrayWithArray:sourcearray];
        
        for (int i=1; i<bigArray.count; i++) {
            NSArray *minArray = [bigArray[i] componentsSeparatedByString:@"px"];
            if (minArray.count < 2) {
                minArray = [bigArray[i] componentsSeparatedByString:@"pt"];
            }
            if (minArray.count < 2) {
                minArray = [bigArray[i] componentsSeparatedByString:@"em"];
            }
            bigArray[i] = minArray[1];
        }
        bbsContent = @"";
        for (NSString *subStr in bigArray) {
            bbsContent = [bbsContent stringByAppendingString:subStr];
        }
    }
    
    //设置字体大小为14，颜色为0x666666，边距为18，并且图片的宽度自动充满屏幕，高度自适应
    NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                       "<head> \n"
                       "<style type=\"text/css\"> \n"
                       "body {margin:18;font-size:14;color:0x666666}\n"
                       "</style> \n"
                       "</head> \n"
                       "<body>"
                       "<script type='text/javascript'>"
                       "window.onload = function(){\n"
                       "var $img = document.getElementsByTagName('img');\n"
                       "for(var p in  $img){\n"
                       " $img[p].style.width = '100%%';\n"
                       "$img[p].style.height ='auto'\n"
                       "}\n"
                       "}"
                       "</script>%@"
                       "</body>"
                       "</html>",bbsContent];
    
    return htmls;
}

+ (NSString *)dateToTimeData:(NSString *)dataString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //指定时间显示样式: HH表示24小时制 hh表示12小时制
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *lastDate = [formatter dateFromString:dataString];
    //以 1970/01/01 GMT为基准，得到lastDate的时间戳
    long timeDate = [lastDate timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%ld", timeDate];
}

+(NSString *)dateToAge:(NSString *)bornString {
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *bornData = [format dateFromString:bornString];
    
    //获得当前系统时间
    NSDate *currentDate = [NSDate date];
    //获得当前系统时间与出生日期之间的时间间隔
    NSTimeInterval time = [currentDate timeIntervalSinceDate:bornData];
    //时间间隔以秒作为单位,求年的话除以60*60*24*356
    int age = ((int)time)/(3600*24*365);
    return [NSString stringWithFormat:@"%d",age];
}
+ (NSString *)changeTimeStampToTime:(NSString *)timeStampStr {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStampStr integerValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *time = [formatter stringFromDate:date];
    return time;
}
+ (NSString *)changeTimeStampToChinaTime:(NSString *)timeStampStr {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStampStr integerValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *time = [formatter stringFromDate:date];
    return time;
}

+ (NSString *)changeTimeStampToYMDTime:(NSString *)timeStampStr {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStampStr integerValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [formatter stringFromDate:date];
    return time;
}

+ (NSString *)changeTimeStampToYMTime:(NSString *)timeStampStr {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStampStr integerValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *time = [formatter stringFromDate:date];
    return time;
}

+(NSString *)getNowTimeTimeStamp {

    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

+ (NSString *)changeToEncryptStringWithNormalString:(NSString *)normalString {
    
    NSString *tempStr = [normalString stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    return tempStr;
}

+ (NSString*)weekdayStringFromDate:(NSString *)inputDateString {
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *inputDate = [inputFormatter dateFromString:inputDateString];
    
    
    NSArray *weekdays = [NSArray arrayWithObjects: @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday - 1];
}

/**
 实现几天前，几小时前，几分钟前
 
 @param string yyyy-MM-dd HH:mm:ss.SSS
 @return 几天前，几小时前，几分钟前
 */
+ (NSString *) compareCurrentTime:(NSString *)string {
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:string];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
//    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

+ (NSString *)emojiCode:(NSString *)normalString {
    
    NSString *uniStr = [NSString stringWithUTF8String:[normalString UTF8String]];
    NSData *uniData = [uniStr dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *goodStr = [[NSString alloc] initWithData:uniData encoding:NSUTF8StringEncoding];
    return goodStr;
}

+ (NSString *)emojiEncode:(NSString *)codeString {
    const char *jsonString = [codeString UTF8String];   // goodStr 服务器返回的 json
    NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
    NSString *emojiString = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
    return emojiString;
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

@end
