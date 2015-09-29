//
//  ViewController.m
//  3DTouchTest
//
//  Created by isaac on 15/9/28.
//  Copyright © 2015年 isaac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIViewControllerPreviewingDelegate>

{
    UIButton *Btn;
}

@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self check3DTouch];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Btn = [[UIButton alloc] init];
    Btn.frame = CGRectMake(100, 100, 200, 200);
    [Btn setTitle:@"点击" forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Btn setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:Btn];
}

/*! @brief  检查3DTouch是否可用 */
- (void)check3DTouch {
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        
        [self registerForPreviewingWithDelegate:(id)self sourceView:Btn];
        NSLog(@"3D Touch 可用!");
        
        self.longPress.enabled = NO;
        
    } else {
        
        NSLog(@"3D Touch 不可用!");
        self.longPress.enabled = YES;
        
    }
}

- (UILongPressGestureRecognizer *)longPress {
    
    if (!_longPress) {
        // 当不支持或未开启的时候,去处理一些事情
        _longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(showPeek)];
        [self.view addGestureRecognizer:_longPress];
    }
    return _longPress;
}

- (void)showPeek {
    
    self.longPress.enabled = NO;
    
    NSLog(@"不支持或未开启3DTouch");
}


#pragma mark - 3D Touch Delegate
/*! @brief   第一次touch触发  */
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    
    NSLog(@"3DTouch被触发");
    
    if ([self.presentedViewController isKindOfClass:[ISTestVC class]]) {
        return nil;
    }
    
    ISTestVC *test = [[ISTestVC alloc] init];
    
    return test;
}

/*! @brief   再次touch触发 viewControllerToCommit为第一次弹出的VC   */
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    NSLog(@"再次Touch");
    
    [self presentViewController:viewControllerToCommit animated:YES completion:nil];
 
}


/*! @brief  检查3DTouch的可用状态 */
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
    NSLog(@"当3DTouch状态开关发生改变时");
    [self check3DTouch];
}

@end
