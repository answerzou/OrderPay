//
//  Utilities.h
//  Financial
//
//  Created by BJJY on 15/3/20.
//  Copyright (c) 2015年 捷越. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//weakself
#define WEAKSELF_SC __weak __typeof(&*self)weakSelf_SC = self;

typedef NS_ENUM(int, RefreshType) {
    HeaderRefreshType = 0,
    FooterRefreshType
};

@interface JYUtilities : NSObject

+ (void)setExtraCellLineHidden:(UITableView *)tableView;
+ (UIBarButtonItem *)setBackButtonTitle;

/**
 *  获取随机数
 *  @param from 随机数的开头
 *  @param to   随机数的结尾
 *  @return 返回开头到结尾的随机数
 */
+ (int)getRandomNumber:(int)from to:(int)to;

/**
 *  把字典转换成json
 *  @param dic 需要转换的字典数据
 *  @return 返回字典换换后的Json字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 *  给相关数组中的多个字典相同key的value进行排序
 *  @param dicArray 字典数组
 *  @param key      想要排序的字典key值
 *  @param yesOrNo  是否按升序排列
 */
+ (void)changeArray:(NSMutableArray *)dicArray orderWithKey:(NSString *)key ascending:(BOOL)yesOrNo;

/**
 *  字符串转Date，字符串格式：yyyy-MM-dd
 *  @param string yyyy-MM-dd格式的字符串
 *  @return 返回日期类型
 */
+ (NSDate *)dateTurnWithString:(NSString *)string;

/**
 *  毫秒时间戳转时间,只显示日期
 *  @param time 时间的毫秒值
 *  @return 返回yyyy-MM-dd格式的时间字符串
 */
+ (NSString*)getMsecDate:(long long)msecL;

//判断两个日期的时间差返回两个时间相差的分钟数
+ (long)timeIntervalSinceNow:(NSDate *)newDate oldDate:(NSDate *)oldDate;

/**
 *  获取当前日期
 *  @return 返回yyyy-MM-dd格式的日期字符串
 */
+ (NSString *)stringWithCurrentDate;

/**
 *  获取当前日期
 *  @return 返回yyyy-MM-dd HH:mm:ss格式的日期字符串
 */
+ (NSString *)stringWithCurrentDateAndTime;

/**
 *  得到当前时间戳
 *  @return 返回当前日期的毫秒数字符串
 */
+ (NSString *)stringWithCurrentDateStamp;

/**
 *  返回星期几
 *  @param inputDate 日期
 *  @return 返回输入日期的星期几
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

/**
 *  千分位格式化
 *  @param num 金额
 *  @return 返回传入格式化后的金额
 */
+ (NSString *)amountFormat:(NSNumber *)num;

/**
 *  MD5加密字符串
 *  @param str 需要加密的字符串
 *  @return 返回加密字符串
 */
+ (NSString *)md5:(NSString *)str;

/**
 *  去除字符串两边空格
 * *  @param kgString 所要去两边空格的字符串
 *  @return 返回去除两边空格的字符串
 */
+ (NSString *)removeSidesSpaces:(NSString *)kgString;
/**
 *  去除字符串空格
 *  @param kgString 需要去除空格的字符串
 *  @return 返回去除空格后的字符串
 */
+ (NSString *)removeSpaces:(NSString*)kgString;

/**
 *  将符串的指定长度变为*号
 *  @param str        需要修改的字符串
 *  @param startIndex 开始位置
 *  @param endIndex   结束位置
 *  @return 修改后的字符串
 */
+ (NSString *)replaceAsterisk:(NSString *)asteriskStr startIndex:(NSInteger)startIndex length:(NSInteger)length;

/**
 *  核对输入是否为空信息
 *  @param text 需要核对的字符串
 *  @return YES:有字符串; NO:没有字符串
 */
+ (BOOL)checkInputText:(NSString*)text;

/**
 *  身份证验证
 *  @param idCard 身份证号
 *  @return YES:是正确身份证; NO:不是有效身份证
 */
+ (BOOL)verifyIDCard:(NSString*)idCard;

/**
 *  手机号码证验证
 *  验证规则:只要是11为数字验证通过
 *  @param phone 手机号
 *  @return YES验证通过，NO验证失败
 */
+ (BOOL)verifyPhoneNumber:(NSString*)phone;

// 小数点验证（后俩位）
+ (BOOL)validateMoney:(NSString *)money;
/**
 *  登录密码正则表达式
 *  验证规则:6-18位字母数字组合
 *  @return YES验证通过，NO验证失败
 */
+ (BOOL)judgePassWordLegal:(NSString *)pass;

/**
 *  用户姓名验证
 *  @param name 验证的姓名
 *  @return YES验证通过，NO验证失败
 */

+ (BOOL)verifyUserName:(NSString*)name;
/**
 *  验证数字
 *  @param number 所需验证数字字符串
 *  @return YES:是数字; NO:不是数字
 */
+ (BOOL)validateNumber:(NSString*)number;
/**
 *  验证正则是否正确
 *
 *  @param info    需要验证的字符串
 *  @param regular 需要验证的正则表达式
 *
 *  @return 字符串是否符合相关正则表达式
 */
+ (BOOL)verifyInputInfo:(NSString*)info regular:(NSString*)regular;
//判断字符串是否是整型
+ (BOOL)jy_isPureInt:(NSString*)string;

/**
 *  获得当前时间戳
 *  @return 返回当前时间的毫秒戳
 */
+ (unsigned long long)nonceWithLoaclTimestamp;

/**
 *  计算火星坐标
 */
+ (NSString *)transformWithwglat:(double)wgLat wglon:(double)wgLon mglat:(double)mgLat mglon:(double)mgLon;

/**
 *  处理json数据中的“\”和头尾的引号
 *  @param string 所要处理的字符串
 *  @return 处理后的字典数据
 */
+ (NSDictionary *)dealResponseString:(NSString *)string;

/**
 *  修改照片方向
 *  @param aImage 要修改的照片
 *  @return 返回修改后的照片
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

//自动缩放到指定大小
+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;

//保持原来的长宽比，生成一个缩略图
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;

/**
 *  获取post是key字段的内容
 *  @return 返回POST所需KEY字符串
 */
//+ (NSString *)getPostKey;

/**
 *  获取用户名
 *  @return 返回用户名
 */
+ (NSString *)getUsername;

/**
 *  获得当前VC
 *  @return 返回当然VC
 */
+ (UIViewController *)activityViewController;

/**
 *  获得顶级VC
 *  @return 返回顶级VC
 */
+ (UIViewController *)appRootViewController;

/**
 *  验证TouchID是否可用
 *  @return 返回YES:可用;  NO:不可用;
 */
+ (BOOL)canTouchID;

/**
 *  验证TouchID是否正确
 *  @param successBlock TouchID验证Block
 */
+ (void)verifyTouchID:(void(^)(BOOL success,NSError *error))successBlock;

/**
 *  把Base64编码字符串转成NSData
 *  @param string Base64编码字符
 *  @return 返回NSData
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;

//压缩图片到指定大小
+ (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;



@end

@interface NSString (JYUtilities)
/**
 *  判断是否包含字符串
 *  @param aString 包含的字符串
 *  @return YES:包含; NO:不包含
 */
- (BOOL)containsString_JY:(NSString *)aString;

/**
 *  将字符串转NSNumber类型
 */
- (NSNumber*)jy_toNumber;

@end


@interface NSObject (JYPropertyList)
/**
*  判断对象属性是否有空值
*  @return YES:有空值; NO:没空值
*/
- (BOOL)propertyHaveEmpty;

/**
 *  把对象转成字典
 *  @return 返回对象的字典形式
 */
- (NSDictionary *)properties_aps;

@end

@interface UILabel (SJEUILabel)

//改变传入label内容的颜色
- (void)changeTextColor:(NSString*)text textColor:(UIColor*)textColor;
//给UILabel设置行间距和字间距
-(void)setLabelLineSpacing:(float)lineSpacing contentSpacing:(float)contentSpacing;


@end


