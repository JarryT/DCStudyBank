//
//  YTCameraAndPhotoManager.m
//  YTTDemo
//
//  Created by jm on 2017/5/10.
//  Copyright © 2017年 TJarry. All rights reserved.
//

#import "YTCameraAndPhotoManager.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import<AssetsLibrary/AssetsLibrary.h>


@interface YTCameraAndPhotoManager()
@property (copy, nonatomic) void(^imageBlock)(UIImage *image);
@property (copy, nonatomic) ActionDictionary videoInfo;
@end

static YTCameraAndPhotoManager *ytUploadImage = nil;
@implementation YTCameraAndPhotoManager

+ (YTCameraAndPhotoManager *)shareUploadImage {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ytUploadImage = [[YTCameraAndPhotoManager alloc] init];
    });
	ytUploadImage.isEdite = YES;
    return ytUploadImage;
}

- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC imageBlock:(void(^)(UIImage *image))block{
    ytUploadImage.imageBlock = block;
	_fatherViewController = fatherVC;
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	//取消
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
	//防止循环引用
	__weak typeof(self) weakSelt = self;
	//选择相册
	UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		[weakSelt fromPhotos];
	}];
	//拍照
	UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		[weakSelt createPhotoView];
	}];
	[alertController addAction:cancelAction];
	[alertController addAction:takePhotoAction];
	[alertController addAction:albumAction];
	[_fatherViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC delegate:(id<YTCameraAndPhotoManagerDelegate>)aDelegate{
    ytUploadImage.uploadImageDelegate = aDelegate;{
        _fatherViewController = fatherVC;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        //取消
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        //防止循环引用
        __weak typeof(self) weakSelt = self;
        //选择相册
        UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [weakSelt fromPhotos];
        }];
        //拍照
        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [weakSelt createPhotoView];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:takePhotoAction];
        [alertController addAction:albumAction];
        [_fatherViewController presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - 头像(相机和从相册中选择)
- (void)createPhotoView {
    //判断设置是否支持拍照
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
//        [TJAlertManager alertWithTarget:self title:@"提示" message:@"该设备不支持拍照" cancelButtonTitle:@"确定" cancel:^{
//            //
//        }];
		[MBProgressHUD showError:@"该设备不支持拍照" toView:[UIApplication sharedApplication].keyWindow];

        return;
    }
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusAuthorized:{
            [self camerAVAuthorizationStatus];
        }break;
            case AVAuthorizationStatusDenied:{
//              [TJAlertManager alertWithTarget:self title:@"提示" message:@"请在隐私设置中开启权限" cancelButtonTitle:@"确定" cancel:^{
//            }];
				[MBProgressHUD showError:@"请在隐私设置中开启权限" toView:[UIApplication sharedApplication].keyWindow];
            return;
        }break;
        default:
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
					dispatch_async(dispatch_get_main_queue(), ^{
						[self camerAVAuthorizationStatus];
					});
                }else{
                }
            }];
        }
            break;
    }
}

- (void)camerAVAuthorizationStatus{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //设置代理
    imagePicker.delegate = self;
    //设置Picker资源类型
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //设置过度类型
    //imagePicker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //是否编辑照片
    imagePicker.allowsEditing = YES;
    [_fatherViewController presentViewController:imagePicker animated:YES completion:nil];
}
//图片库方法(从手机的图片库中查找图片)
- (void)fromPhotos {
	if ([[UIDevice currentDevice] systemVersion].floatValue < 11.0) {
		//相册权限
		ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author ==ALAuthorizationStatusDenied || author ==ALAuthorizationStatusRestricted){
			[MBProgressHUD showTip:@"请在设置中手动开启权限" toView:ApplicationKeyWindow];
			return;
		}
	}

	UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //imagePicker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    imagePicker.allowsEditing = YES;
    [_fatherViewController presentViewController:imagePicker animated:YES completion:nil];

}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    weakSelf(self);
    //   发现视频
	NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];

	if ([mediaType isEqualToString:@"public.movie"]){
			//如果是视频
		NSURL *url = info[UIImagePickerControllerMediaURL];//获得视频的URL
		UIImage *videoImage = [self getVideoPreViewImage:url];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			if (weakSelf.videoInfo) {
				weakSelf.videoInfo(@{@"url":url,@"image":videoImage});
			}
		});
    }else{
        /**
        代理回调
         */
		UIImage *image =[info objectForKey: _isEdite ? UIImagePickerControllerEditedImage : UIImagePickerControllerOriginalImage];
        if (self.uploadImageDelegate && [self.uploadImageDelegate respondsToSelector:@selector(uploadHeaderImageToServerWithImage:)]) {
            [self.uploadImageDelegate uploadHeaderImageToServerWithImage:image];
        }
		
		dispatch_async(dispatch_get_main_queue(), ^{
			if (weakSelf.imageBlock) {
				weakSelf.imageBlock(image);
			}
		});
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////

- (void)showActionSheetInFatherViewController:(UIViewController *)fatherVC videoInfo:(ActionDictionary)block{
	ytUploadImage.videoInfo = block;
	_fatherViewController = fatherVC;
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
		//取消
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
		//防止循环引用
	__weak typeof(self) weakSelt = self;
		//选择相册
	UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		[weakSelt videoFromPhotos];
	}];
//		//拍照
//	UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//		[weakSelt createVideoView];
//	}];
	[alertController addAction:cancelAction];
//	[alertController addAction:takePhotoAction];
	[alertController addAction:albumAction];
	[_fatherViewController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 头像(相机和从相册中选择)
- (void)createVideoView {
		//判断设置是否支持拍照
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
			//        [TJAlertManager alertWithTarget:self title:@"提示" message:@"该设备不支持拍照" cancelButtonTitle:@"确定" cancel:^{
			//            //
			//        }];
		[MBProgressHUD showError:@"该设备不支持拍视频" toView:[UIApplication sharedApplication].keyWindow];
		return;
	}
	AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
	switch (authStatus) {
		case AVAuthorizationStatusAuthorized:{
			[self videoAVAuthorizationStatus];
		}break;
		case AVAuthorizationStatusDenied:{
				//              [TJAlertManager alertWithTarget:self title:@"提示" message:@"请在隐私设置中开启权限" cancelButtonTitle:@"确定" cancel:^{
				//            }];
			[MBProgressHUD showError:@"请在隐私设置中开启权限" toView:[UIApplication sharedApplication].keyWindow];
			return;
		}break;
		default:
	 {
		[AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
			if (granted) {
				[self videoAVAuthorizationStatus];
			}else{
			}
		}];
	 }
			break;
	}
}

- (void)videoAVAuthorizationStatus{
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
		//设置代理
	imagePicker.delegate = self;
		//设置Picker资源类型
	imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
	imagePicker.allowsEditing = NO;
	imagePicker.videoMaximumDuration = 1.0;//视频最长长度
	imagePicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
		//媒体类型：@"public.movie" 为视频  @"public.image" 为图片
	imagePicker.mediaTypes = @[@"public.movie"];
	imagePicker.sourceType= UIImagePickerControllerSourceTypeCamera;
	[_fatherViewController presentViewController:imagePicker animated:YES completion:nil];
}
	//图片库方法(从手机的图片库中查找视频)
- (void)videoFromPhotos {
	if ([[UIDevice currentDevice] systemVersion].floatValue < 11.0) {
			//相册权限
		ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author ==ALAuthorizationStatusDenied || author ==ALAuthorizationStatusRestricted){
			[MBProgressHUD showTip:@"" toView:ApplicationKeyWindow];
			return;
		}
	}
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
	imagePicker.delegate = self;
	imagePicker.allowsEditing = NO;
	imagePicker.videoMaximumDuration = 1.0;//视频最长长度
	imagePicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
	//媒体类型：@"public.movie" 为视频  @"public.image" 为图片
	imagePicker.mediaTypes = @[@"public.movie"];
	imagePicker.sourceType= UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	[_fatherViewController presentViewController:imagePicker animated:YES completion:nil];
}
//获取视频的第一帧图片
- (UIImage*) getVideoPreViewImage:(NSURL *)path
{
	AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
	AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];

	assetGen.appliesPreferredTrackTransform = YES;
	CMTime time = CMTimeMakeWithSeconds(0.0, 600);
	NSError *error = nil;
	CMTime actualTime;
	CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
	UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
	CGImageRelease(image);
	return videoImage;
}
//获取视频大小
/**
 * @method
 *
 * @brief 根据路径获取视频时长和大小
 * @param path       视频路径
 * @return    字典    @"size"－－文件大小   @"duration"－－视频时长
 */
- (NSDictionary *)getVideoInfoWithSourcePath:(NSString *)path{
	AVURLAsset * asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:path]];
	CMTime   time = [asset duration];
	int seconds = ceil(time.value/time.timescale);

	NSInteger   fileSize = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil].fileSize;

	return @{@"size" : @(fileSize),
			 @"duration" : @(seconds)};
}
@end
