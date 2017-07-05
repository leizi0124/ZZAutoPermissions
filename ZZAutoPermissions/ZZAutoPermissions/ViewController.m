//
//  ViewController.m
//  ZZAutoPermissions
//
//  Created by Cheng Rong on 2017/7/4.
//  Copyright © 2017年 Zhao Zhenlei. All rights reserved.
//

#import "ViewController.h"
#import "ZZAutoPrivacyPers.h"
#import <objc/runtime.h>
@interface ViewController ()<UITextViewDelegate,UIGestureRecognizerDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titleArray = @[@"麦克风",@"相机",@"相册",@"通讯录"];
    CGRect frame = CGRectMake(0, 100, self.view.frame.size.width / 4.0, 50);
    for (NSInteger index = 0; index < titleArray.count; index++) {
        UIButton *priBtn = [[UIButton alloc] initWithFrame:frame];
        [priBtn setTitle:[titleArray objectAtIndex:index] forState:UIControlStateNormal];
        [priBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        priBtn.tag = index + 100;
        [priBtn addTarget:self action:@selector(priBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:priBtn];
        
        if ((index + 1) % 4 == 0) {
            frame = CGRectMake(0, CGRectGetMaxY(frame), frame.size.width, frame.size.height);
        }else {
            frame = CGRectOffset(frame, frame.size.width, 0);
        }
    }
}
- (void)priBtnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 100:{
            [ZZAutoPrivacyPers getMicrophonePermission:^(BOOL result) {
                if (result) {
                    NSLog(@"麦克风 授权 成功");
                }else {
                    NSLog(@"麦克风 授权 失败");
                }
            }];
        }
            break;
        case 101:{
            [ZZAutoPrivacyPers getCameraPermission:^(BOOL result) {
                if (result) {
                    NSLog(@"相机 授权 成功");
                }else {
                    NSLog(@"相机 授权 失败");
                }
            }];
        }
            break;
        case 102:{
            [ZZAutoPrivacyPers getPhotoLibraryPermission:^(BOOL result) {
                if (result) {
                    NSLog(@"相册 授权 成功");
                }else {
                    NSLog(@"相册 授权 失败");
                }
            }];
        }
            break;
        case 103:{
            [ZZAutoPrivacyPers getContactsPermission:^(BOOL result) {
                if (result) {
                    NSLog(@"通讯录 授权 成功");
                }else {
                    NSLog(@"通讯录 授权 失败");
                }
            }];
        }
        default:
            break;
    }
}
@end
