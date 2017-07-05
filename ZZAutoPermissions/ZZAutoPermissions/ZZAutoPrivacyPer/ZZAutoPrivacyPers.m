//
//  ZZAutoPrivacyPers.m
//  ZZAutoPermissions
//
//  Created by Cheng Rong on 2017/7/4.
//  Copyright © 2017年 Zhao Zhenlei. All rights reserved.
//

#import "ZZAutoPrivacyPers.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import <AssetsLibrary/AssetsLibrary.h>
@implementation ZZAutoPrivacyPers
/**
 获取麦克风权限
 */
+ (void)getMicrophonePermission:(void(^)(BOOL result))zzBlock {
    
    AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (videoAuthStatus) {
        case AVAuthorizationStatusNotDetermined:{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                if (granted){   // 用户同意授权
                    zzBlock(YES);
                }else {         // 用户拒绝授权
                    zzBlock(NO);
                }
            }];
        }
            break;
        case AVAuthorizationStatusRestricted:       //未授权
        case AVAuthorizationStatusDenied:           //未授权
            zzBlock(NO);
            break;
        case AVAuthorizationStatusAuthorized:       //已授权
            zzBlock(YES);
            break;
        default:
            break;
    }
}
/**
 获取相机权限
 */
+ (void)getCameraPermission:(void(^)(BOOL result))zzBlock {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:{    //未进行过授权操作
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    zzBlock(YES);
                }else{
                    zzBlock(NO);
                }
            }];
        }
            break;
        case ALAuthorizationStatusRestricted:       //未授权
        case ALAuthorizationStatusDenied:           //未授权
            zzBlock(NO);
            break;
        case ALAuthorizationStatusAuthorized:       //授权
            zzBlock(YES);
            break;
        default:
            break;
    }
}
/**
 获取相册权限
 */
+ (void)getPhotoLibraryPermission:(void(^)(BOOL result))zzBlock {
    BOOL needAuth;
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0) {
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        switch (authStatus) {
            case ALAuthorizationStatusNotDetermined:    //未进行过授权操作
                needAuth = YES;
                break;
            case ALAuthorizationStatusRestricted:       //未授权
            case ALAuthorizationStatusDenied:           //未授权
                zzBlock(NO);
                break;
            case ALAuthorizationStatusAuthorized:       //授权
                zzBlock(YES);
                break;
            default:
                break;
        }
    }else {
        PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
        
        switch (authStatus) {
            case PHAuthorizationStatusAuthorized:       //未进行过授权操作
                needAuth = YES;
                break;
            case PHAuthorizationStatusDenied:           //未授权
            case PHAuthorizationStatusNotDetermined:    //未授权
                zzBlock(NO);
                break;
            case PHAuthorizationStatusRestricted:       //授权
                zzBlock(YES);
                break;
            default:
                break;
        }
    }
    
    if (needAuth) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                zzBlock(YES);
            }else{
                zzBlock(NO);
            }
        }];
    }
}
/**
 获取通讯录权限
 */
+ (void)getContactsPermission:(void(^)(BOOL result))zzBlock {
    
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_9_0) {
        ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
        switch (authStatus) {
            case kABAuthorizationStatusNotDetermined:{//未进行过授权操作
                ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
                ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                    if (granted) {
                        zzBlock(YES);
                        CFRelease(addressBook);
                    }else{
                        zzBlock(NO);
                    }
                });
            }
                break;
            case kABAuthorizationStatusRestricted://未授权 可能被限制
            case kABAuthorizationStatusDenied://明确拒绝授权
                zzBlock(NO);
                break;
            case kABAuthorizationStatusAuthorized://已授权
                zzBlock(YES);
                break;
            default:
                break;
        }
    } else {
        CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (authStatus) {
            case CNAuthorizationStatusNotDetermined:{//未进行过授权操作
                CNContactStore *contactStore = [[CNContactStore alloc] init];
                [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    if (granted) {
                        zzBlock(YES);
                    } else {
                        zzBlock(NO);
                    }
                }];
            }
                break;
            case CNAuthorizationStatusRestricted:   //未授权 可能被限制
            case CNAuthorizationStatusDenied:       //明确拒绝授权
                zzBlock(NO);
                break;
            case CNAuthorizationStatusAuthorized:   //已授权
                zzBlock(YES);
                break;
            default:
                break;
        }
    }
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
