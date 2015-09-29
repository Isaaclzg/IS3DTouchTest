//
//  ISTestVC.m
//  3DTouchTest
//
//  Created by isaac on 15/9/29.
//  Copyright © 2015年 isaac. All rights reserved.
//

#import "ISTestVC.h"

@interface ISTestVC ()

@end

@implementation ISTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backView)];
    [self.view addGestureRecognizer:tap];
    
    [self check3DTouch];
}

- (void)backView
{
    [self dismissViewControllerAnimated:YES completion:nil      ];
}

#pragma mark - Preview Actions
/*! @brief  当此VC为Touch进入时调用 */
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    
    // setup a list of preview actions
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"11");
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"2" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"22");
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"33" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"33");
    }];
    
    
    NSArray *actions = @[action1, action2, action3];
    
    
    UIPreviewActionGroup *group1 = [UIPreviewActionGroup actionGroupWithTitle:@"展开" style:UIPreviewActionStyleDefault actions:actions];
    
    NSArray *group = @[group1];
  
    return group;
}

- (void)check3DTouch {
    
    // 如果3DTouch不可用，返回
    if (self.traitCollection.forceTouchCapability != UIForceTouchCapabilityAvailable) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissMe)];
        [self.view addGestureRecognizer:tap];
    }
}

- (void)dismissMe{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
