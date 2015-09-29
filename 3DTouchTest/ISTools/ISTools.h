// 常用工具类 By:Isaac_gang
//  Tools.h
//  HelloWorld
//
//  Created by isaac on 15/7/13.
//  Copyright (c) 2015年 isaac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IS_MBProgressHUD.h"
// iOS版本
#define IOS_VERSION     [[[UIDevice currentDevice] systemVersion] floatValue]

// 获取物理屏幕宽度
#define  kWidth         [UIScreen mainScreen].bounds.size.width

// 获取物理屏幕高度
#define  kHeight        [UIScreen mainScreen].bounds.size.height

// 根据颜色的RGB绘制颜色
#define  kColor(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// NavigationBar高度
#define kNavigationBarHeight    ((IOS_VERSION >= 7.0f) ? 64.0f : 44.0f)



@interface ISTools : NSObject

/*! @brief NSString ← NSDate(需要输入时间格式) */
+ (NSString *)stringFromDateWithFormat:(NSDate *)date format:(NSString*)pformat;

/*! @brief   NSString → NSDate(需要输入时间格式) Ps：@"yyyy-MM-dd HH:mm:ss.SSS" */
+ (NSDate *)dateFromString:(NSString *)dateString
                timeFormat:(NSString *)format;
/*! @brief   判断字符串是否为空 */
+ (BOOL)isEmptyString:(NSString *)thestring;

/*! @brief   字符串转URL */
+ (NSURL *)strURL:(NSString *)str;

/*! @brief   默认头像 */
+ (UIImage *)avatarImage;

/*! @brief   Default的图片 */
+ (UIImage *)picLoadImage;

/*! @brief   设置UITextField的leftView */
+ (void)textFieldSetLeftView:(UITextField *)textfield
                  setImgName:(NSString *)imgName;

/*! @brief   UILabel中计算字符串的宽度（系统字体、MAX为屏幕宽度） */
+ (CGFloat)LabelCountWidth:(NSString *)mstr
                  FontSize:(NSInteger)size;

/*! @brief   UILabel中计算字符串的高度（系统字体、MAX为屏幕宽度 */
+ (CGFloat)LabelCountHeight:(NSString *)mstr
                   FontSize:(NSInteger)size;

/*! @brief   UILabel中计算字符串的宽度和高度 （字体，MAX可定制） */
+ (CGRect)LabelSize:(NSString *)str
               Font:(UIFont *)font
           MAXWidth:(CGFloat)width;

/*! @brief   UITextView 动态计算高度（MAX宽度为屏幕宽度） */
+ (CGFloat)textViewHeight:(NSString *)text
                     font:(UIFont *)font;

/*! @brief  处理返回的数据*/
+ (NSString *)dicHandle:(NSDictionary *)dic
                    key:(NSString *)key;

/*! @brief  HUD只显示文字*/
+ (void)hud:(UIView *)view
       Text:(NSString *)text;

/*! @brief  HUD显示文字和状态 YES/ NO*/
+ (void)hud:(UIView *)view Text:(NSString *)text State:(BOOL)isSuccess;

/*! @brief  HUD返回一个带菊花的*/
+ (MBProgressHUD *)hudLoading:(UIView *)view Text:(NSString *)text;

@end
