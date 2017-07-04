//
//  ViewController.m
//  ZZAutoPermissions
//
//  Created by Cheng Rong on 2017/7/4.
//  Copyright © 2017年 Zhao Zhenlei. All rights reserved.
//

#import "ViewController.h"
#import "ZZAutoPrivacyPers.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titleArray = @[@"麦克风",@"相机",@"相册",@"通讯录",@"蓝牙",@"语音识别",@"日历",@"临时定位",@"一直定位"];
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
            [ZZAutoPrivacyPers getMicrophonePermission];
        }
            break;
        case 101:{
            [ZZAutoPrivacyPers getCameraPermission];
        }
            break;
        case 102:{
            [ZZAutoPrivacyPers getPhotoLibraryPermission];
        }
            break;
        case 103:{
            [ZZAutoPrivacyPers getContactsPermission];
        }
            break;
        case 104:{
            [ZZAutoPrivacyPers getBluetoothPermission];
        }
            break;
        case 105:{
            [ZZAutoPrivacyPers getSpeechRecognitionPermission];
        }
            break;
        case 106:{
            [ZZAutoPrivacyPers getCalendarsPermission];
        }
            break;
        case 107:{
            [ZZAutoPrivacyPers getLocationWhenPermission];
        }
            break;
        case 108:{
            [ZZAutoPrivacyPers getLocationAlwaysPermission];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
