//
//  ZZAutoPrivacyPers.m
//  ZZAutoPermissions
//
//  Created by Cheng Rong on 2017/7/4.
//  Copyright © 2017年 Zhao Zhenlei. All rights reserved.
//

#import "ZZAutoPrivacyPers.h"
#import <Photos/Photos.h>
@implementation ZZAutoPrivacyPers
/**
 获取麦克风权限
 */
+ (void)getMicrophonePermission {
    
}
/**
 获取相机权限
 */
+ (void)getCameraPermission {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            NSLog(@"允许相册");
        }else{
            NSLog(@"不允许相册");
        }
    }];
}
/**
 获取相册权限
 */
+ (void)getPhotoLibraryPermission {
    PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
    switch (photoAuthorStatus) {
        case PHAuthorizationStatusAuthorized:
            NSLog(@"允许授权");
            break;
        case PHAuthorizationStatusDenied:
            NSLog(@"不允许授权");
            break;
        case PHAuthorizationStatusNotDetermined:
            NSLog(@"不确定");
            break;
        case PHAuthorizationStatusRestricted:
            NSLog(@"限制");
            break;
        default:
            break;
    }
}
/**
 获取通讯录权限
 */
+ (void)getContactsPermission {
    
}
/**
 获取蓝牙权限
 */
+ (void)getBluetoothPermission {
    
}
/**
 获取语音转文字权限
 */
+ (void)getSpeechRecognitionPermission {
    
}
/**
 获取日历权限
 */
+ (void)getCalendarsPermission {
    
}
/**
 获取使用时定位权限
 */
+ (void)getLocationWhenPermission {
    
}
/**
 获取总是定位权限
 */
+ (void)getLocationAlwaysPermission {
    
}
@end
//麦克风权限：Privacy - Microphone Usage Description 是否允许此App使用你的麦克风？
//相机权限： Privacy - Camera Usage Description 是否允许此App使用你的相机？
//相册权限： Privacy - Photo Library Usage Description 是否允许此App访问你的媒体资料库？
//通讯录权限： Privacy - Contacts Usage Description 是否允许此App访问你的通讯录？
//蓝牙权限：Privacy - Bluetooth Peripheral Usage Description 是否许允此App使用蓝牙？
//语音转文字权限：Privacy - Speech Recognition Usage Description 是否允许此App使用语音识别？
//日历权限：Privacy - Calendars Usage Description 是否允许此App使用日历？
//定位权限：Privacy - Location When In Use Usage Description 我们需要通过您的地理位置信息获取您周边的相关数据
//定位权限: Privacy - Location Always Usage Description 我们需要通过您的地理位置信息获取您周边的相关数据
