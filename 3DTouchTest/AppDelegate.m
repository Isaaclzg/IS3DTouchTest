//
//  AppDelegate.m
//  3DTouchTest
//
//  Created by isaac on 15/9/28.
//  Copyright © 2015年 isaac. All rights reserved.
//

#import "AppDelegate.h"
#import "ISTools.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self checkFingerprint];
    
    [self creatIconTouch];
    
    UIApplicationShortcutItem *item = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    if (item) {
        NSLog(@"We've launched from shortcut item: %@", item.localizedTitle);
    } else {
        NSLog(@"We've launched properly.");
    }
    return YES;
}

/*! @brief   创建icon的3DTouch */
- (void)creatIconTouch
{
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"草"];
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"擦"];
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"GG"];
    
    // create several (dynamic) shortcut items
    UIMutableApplicationShortcutItem *item = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.test.love" localizedTitle:@"1" localizedSubtitle:@"子标题" icon:icon1 userInfo:nil];
    UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.test.love" localizedTitle:@"德玛西亚之力" localizedSubtitle:@"盖伦" icon:icon1 userInfo:nil];
    UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.test.mail" localizedTitle:@"德玛西亚皇子" localizedSubtitle:@"嘉文四世" icon:icon2 userInfo:nil];
    UIMutableApplicationShortcutItem *item3 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.test.prohibited" localizedTitle:@"德邦总管" localizedSubtitle:@"赵信" icon:icon3 userInfo:nil];
    
    // add all items to an array
    NSArray *items = @[item,item1, item2, item3];
    
    // add the array to our app
    [UIApplication sharedApplication].shortcutItems = items;
}

#pragma mark - 3DTouch Action
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    // react to shortcut item selections
    NSLog(@"A shortcut item was pressed. It was %@.", shortcutItem.localizedTitle);
    
    if ([shortcutItem.localizedTitle isEqualToString:@"1"]) {
        
        [ISTools hud:self.window Text:@"你点了1"];
    }
}

/*! @brief   指纹验证 */
- (void)checkFingerprint
{
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    
//     context.localizedFallbackTitle = @""; // 如需移除输入密码按钮, 必须设置该字符串为空
    
    // 判断是否能验证指纹
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        // 判断验证指纹的结果
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:NSLocalizedString(@"使用指纹登录", nil) reply:^(BOOL success, NSError *error) {
            if (success) {
                NSLog(@"登录成功");
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"更新UI");
                
                    
                });
            } else {
                switch (error.code) {
                    case LAErrorUserCancel:
                        NSLog(@"手动取消了验证"); // 用户点击了取消按钮时调用
                        break;
                        
                    case LAErrorAuthenticationFailed: // 验证失败时调用(连续3次验证没通过)
                        NSLog(@"验证失败");
                        break;
                        
                    case LAErrorSystemCancel:
                        NSLog(@"验证被系统取消"); // 当锁频,接入电话等情况会调用
                        break;
                        
                    case LAErrorUserFallback:
                        NSLog(@"使用密码登录"); // 用户点击了使用密码按钮时调用, 密码登录模块需自己实现
                        break;
                    default:
                        break;
                }
            }
        }];
    } else {
        switch (error.code) {
            case LAErrorPasscodeNotSet:
                NSLog(@"没有设置密码"); // 登记指纹一定要设置密码, 所以当没有设置密码时, 无法进行指纹验证
                break;
                
            case LAErrorTouchIDNotEnrolled:
                NSLog(@"没有登记指纹"); // 没有登记指纹时, 无法进行指纹验证
                break;
                
            case LAErrorTouchIDNotAvailable:
                NSLog(@"设备不支持指纹"); // 设备不支持指纹时, 无法进行指纹验证
                break;
            default:
                break;
        }
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // 每次从后台键入app时，调用指纹
    
    // [self checkFingerprint];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
