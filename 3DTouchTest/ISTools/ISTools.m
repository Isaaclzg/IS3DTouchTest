//
//  Tools.m
//  HelloWorld
//
//  Created by isaac on 15/7/13.
//  Copyright (c) 2015年 isaac. All rights reserved.
//

#import "ISTools.h"
@implementation ISTools

#pragma mark - NSString → NSDate(需输入时间格式)
+ (NSDate *)dateFromString:(NSString *)dateString
                timeFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

#pragma mark - NSString ← NSDate(需输入时间格式)
+ (NSString *)stringFromDateWithFormat:(NSDate *)date format:(NSString*)pformat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

#pragma mark - 判断字符串是否为空
+ (BOOL) isEmptyString:(NSString *) thestring
{
    if ( !thestring || thestring == nil || thestring == Nil) {
        return YES;
    }

    if (thestring == nil)
    {
        return YES;
    }
    if (thestring == NULL)
    {
        return YES;
    }
    if ([thestring isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([thestring isEqual:[NSNull null]]) {
        return YES;
    }
    if ([thestring isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([thestring isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([[thestring stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
    {
        return YES;
    }
    return NO;
}

#pragma mark - NSString转NSURL
+ (NSURL *)strURL:(NSString *)str
{
    NSURL *url = [NSURL URLWithString:str];
    return url;
}

#pragma mark - 默认头像
+ (UIImage *)avatarImage
{
    UIImage *userAvatarImage = [UIImage imageNamed:@"头像.png"];
    return userAvatarImage;
}

#pragma mark - 默认未获取的图片
+ (UIImage *)picLoadImage
{
    
    UIImage *picLoadingImage = [UIImage imageNamed:@"chunse.jpg"];
    return picLoadingImage;
}

#pragma mark - 设置UITextField的leftView
+ (void)textFieldSetLeftView:(UITextField *)textfield
                  setImgName:(NSString *)imgName
{
    UIImageView *uNameImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
    textfield.leftView = uNameImage;
    textfield.leftView.frame = CGRectMake(0, 0, 40, 20);
    textfield.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark - UILabel中计算字符串的宽度（系统字体、MAX为屏幕宽度）
+ (CGFloat)LabelCountWidth:(NSString *)mstr
                  FontSize:(NSInteger)size
{
    if ([ISTools isEmptyString:mstr]) {
        return 0;
    }
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [UIFont systemFontOfSize:size], NSFontAttributeName,
                          [UIColor darkTextColor], NSForegroundColorAttributeName,nil];
    
    NSStringDrawingContext *dcontext = [[NSStringDrawingContext alloc] init];
    CGRect contentRect = [mstr boundingRectWithSize:CGSizeMake(kWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:dcontext];
    
    return contentRect.size.width;
}

#pragma mark - UILabel中计算字符串的高度（系统字体、MAX为屏幕宽度）
+ (CGFloat)LabelCountHeight:(NSString *)mstr
                   FontSize:(NSInteger)size
{
    if ([ISTools isEmptyString:mstr]) {
        return 0;
    }
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [UIFont systemFontOfSize:size], NSFontAttributeName,
                          [UIColor darkTextColor], NSForegroundColorAttributeName,nil];
    
    NSStringDrawingContext *dcontext = [[NSStringDrawingContext alloc] init];
    CGRect contentRect = [mstr boundingRectWithSize:CGSizeMake(kWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:dcontext];
    
    return contentRect.size.height;
}

#pragma mark - UILabel中计算字符串的宽度和高度 （字体，MAX可定制）
+ (CGRect)LabelSize:(NSString *)str
               Font:(UIFont *)font
           MAXWidth:(CGFloat)width
{
    if ([ISTools isEmptyString:str]) {
        return CGRectZero;
    }
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          font, NSFontAttributeName,
                          [UIColor darkTextColor], NSForegroundColorAttributeName,nil];
    
    NSStringDrawingContext *dcontext = [[NSStringDrawingContext alloc] init];
    CGRect contentRect = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:dcontext];
    
    return contentRect;
}

#pragma mark - UITextView 动态计算高度（MAX宽度为屏幕宽度）
+ (CGFloat)textViewHeight:(NSString *)text
                     font:(UIFont *)font
{
    if ([ISTools isEmptyString:text]) {
        return 0;
    }
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          font, NSFontAttributeName,
                          [UIColor darkTextColor], NSForegroundColorAttributeName,nil];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:text attributes:dict];
    
    UITextView *textView = [[UITextView alloc] init];
    [textView setAttributedText:attributedString];
    CGSize size = [textView sizeThatFits:CGSizeMake(kWidth, FLT_MAX)];
    return size.height;
}

+ (NSString *)dicHandle:(NSDictionary *)dic key:(NSString *)key
{
    NSString *str = [NSString stringWithFormat:@"%@",[dic valueForKey:key]];
    if ([ISTools isEmptyString:str]) {
        str = @"未知";
    }
     return str;
}

+ (void)hud:(UIView *)view Text:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

+ (void)hud:(UIView *)view Text:(NSString *)text State:(BOOL)isSuccess
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = text;
    NSString *imageName = nil;
    if (isSuccess == YES) {
        
        imageName = @"ISHUD_success";
        
    }else
    {
        imageName = @"ISHUD_error";
    }
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
    
}

+ (MBProgressHUD *)hudLoading:(UIView *)view Text:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}
@end
