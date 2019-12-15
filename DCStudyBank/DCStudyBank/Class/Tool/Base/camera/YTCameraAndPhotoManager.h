//
//  YTCameraAndPhotoManager.h
//  YTTDemo
//
//  Created by jm on 2017/5/10.
//  Copyright © 2017年 TJarry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@protocol YTCameraAndPhotoManagerDelegate <NSObject>

- (void)uploadHeaderImageToServerWithImage:(UIImage *)image;
@end
@interface YTCameraAndPhotoManager : NSObject<UINavigationControllerDelegate,
UIImagePickerControllerDelegate>{
    
     UIViewController *_fatherViewController;
}
@property(assign, nonatomic) BOOL isEdite;//默认YES  是否使用编辑后的照片
+ (YTCameraAndPhotoManager *)shareUploadImage;
@property (nonatomic, weak) id <YTCameraAndPhotoManagerDelegate> uploadImageDelegate;
//弹出选项的方法
- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC
                                     delegate:(id<YTCameraAndPhotoManagerDelegate>)aDelegate;
- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC imageBlock:(void(^)(UIImage *image))block;

//视频
/**
 showActionSheetInFatherViewController

 @param fatherVC fatherVC description
 @param block @{@"url":url,@"image":videoImage}
 */
- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC videoInfo:(ActionDictionary)block;
@end
