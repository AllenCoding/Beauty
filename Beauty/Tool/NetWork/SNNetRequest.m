//
//  ShareFit
//
//  Created by YNTS on 2017/9/28.
//  Copyright © 2017年 YNTS. All rights reserved.
//

#import "SNNetRequest.h"
#import "SNNetRequestManager.h"

@interface SNNetRequest ()

@end

@implementation SNNetRequest

// 默认请求二进制
// 默认响应是JSON

+ (void)postWithUrl:(NSString *)url
      andParameters:(NSDictionary *)params
         andSuccess:(HttpSuccessBlock)success
            andFail:(HttpFailureBlock)failure
{
    if (url == nil) {
        url = @"";
    }
    if (params == nil) {
        params = @{};
    }

    [[SNNetRequestManager shareRequestManager]POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success == nil) return ;
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        success(json);
        NSLog(@"----%@----",json);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure == nil) return ;
        failure(error);
    }];
}





+ (void)getWithUrl:(NSString *)url
     andParameters:(NSDictionary *)params
        andSuccess:(HttpSuccessBlock)success
           andFail:(HttpFailureBlock)failure
{
    if (url == nil) {
        url = @"";
    }
    if (params == nil) {
        params = @{};
    }
    
  NSString*  urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    
    [[SNNetRequestManager shareRequestManager] GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success == nil) return ;
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        success(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure == nil) return ;
        failure(error);
    }];
}

+ (void)postUploadSingleImageWithUrl:(NSString *)url
                        andImageName:(UIImage *)image
                          andKeyName:(NSString *)keyName
                       andParameters:(NSDictionary *)params
                          andSuccess:(HttpSuccessBlock)success
                             andFail:(HttpFailureBlock)failure {
    if (url == nil) {
        url = @"";
    }
    if (params == nil) {
        params = @{};
    }
    if (image == nil) {
        image = [UIImage imageNamed:@""];
    }
    if (keyName == nil) {
        keyName = @"";
    }
    
    [[SNNetRequestManager shareRequestManager] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *suffix,*contentType;
        NSData * imageData;
        
        //判断图片是不是png格式的文件
        if (UIImagePNGRepresentation(image)) {
            //返回为png图像。
            imageData = UIImagePNGRepresentation(image);
            suffix = @"png";
            contentType = @"image/png";
        }else {
            //返回为JPEG图像。
            imageData = UIImageJPEGRepresentation(image, 1.0);
            suffix = @"jpg";
            contentType = @"image/jpeg";
        }
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd-HH:mm:ss"];
        NSString * appendStringToImageName = [formatter stringFromDate:[NSDate date]];
        NSString * imageName = [NSString stringWithFormat:@"iPhone_%@.%@",appendStringToImageName,suffix];
        
        [formData appendPartWithFileData:imageData name:keyName fileName:imageName mimeType:contentType];

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success == nil) return ;
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        success(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure == nil) return ;
        failure(error);
    }];

    
}

+ (void)postUploadMultipleImagesWithUrl:(NSString *)url
                          andImageNames:(NSArray *)images
                             andKeyName:(NSString *)keyName
                          andParameters:(NSDictionary *)params
                             andSuccess:(HttpSuccessBlock)success
                                andFail:(HttpFailureBlock)failure {
    if (url == nil) {
        url = @"";
    }
    if (params == nil) {
        params = @{};
    }
    if (images == nil) {
        images = @[];
    }
    if (keyName == nil) {
        keyName = @"";
    }
    
    [[SNNetRequestManager shareRequestManager] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSInteger i = 0; i < images.count; i++) {
            NSString *suffix,*contentType;
            NSData * imageData;
            
            //判断图片是不是png格式的文件
            if (UIImagePNGRepresentation(images[i])) {
                //返回为png图像。
                imageData = UIImagePNGRepresentation(images[i]);
                suffix = @"png";
                contentType = @"image/png";
            }else {
                //返回为JPEG图像。
                imageData = UIImageJPEGRepresentation(images[i], 1.0);
                suffix = @"jpg";
                contentType = @"image/jpeg";
            }
            
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy/MM/dd-HH:mm:ss"];
            NSString * appendStringToImageName = [formatter stringFromDate:[NSDate date]];
            NSString * imageName = [NSString stringWithFormat:@"iPhone_%ld%@.%@",(long)(i+10),appendStringToImageName,suffix];
            NSString * keyN;
            if (images.count == 1) {
                keyN = [NSString stringWithFormat:@"%@[0]",keyName];
            } else {
                keyN = [NSString stringWithFormat:@"%@[%ld]",keyName,(long)i];
            }
            [formData appendPartWithFileData:imageData name:keyN fileName:imageName mimeType:contentType];
            
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success == nil) return ;
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        success(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure == nil) return ;
        failure(error);
    }];
}

+ (void)postUploadMultipleImagesWithUrl:(NSString *)url
                        andImagesAndNames:(NSDictionary *)imageAndNames
                          andParameters:(NSDictionary *)params
                                andSuccess:(HttpSuccessBlock)success
                                andFail:(HttpFailureBlock)failure {
    if (url == nil) {
        url = @"";
    }
    if (imageAndNames == nil) {
        imageAndNames = @{};
    }
    if (params == nil) {
        params = @{};
    }
    
    NSArray * keys = [imageAndNames allKeys];
    NSArray * keyNames = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        
        return result == NSOrderedDescending;
    }];
    
    [[SNNetRequestManager shareRequestManager] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSInteger i = 0; i < keyNames.count; i++) {
            
            NSString * keyN = keyNames[i];
            
            NSString *suffix,*contentType;
            NSData * imageData;
            //判断图片是不是png格式的文件
            if (UIImagePNGRepresentation(imageAndNames[keyN])) {
                //返回为png图像。
                imageData = UIImagePNGRepresentation(imageAndNames[keyN]);
                suffix = @"png";
                contentType = @"image/png";
            }else {
                //返回为JPEG图像。
                imageData = UIImageJPEGRepresentation(imageAndNames[keyN], 1.0);
                suffix = @"jpg";
                contentType = @"image/jpeg";
            }
            
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy/MM/dd-HH:mm:ss"];
            NSString * appendStringToImageName = [formatter stringFromDate:[NSDate date]];
            NSString * imageName = [NSString stringWithFormat:@"iPhone_%ld%@.%@",(long)(i+10),appendStringToImageName,suffix];
            [formData appendPartWithFileData:imageData name:keyN fileName:imageName mimeType:contentType];
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success == nil) return ;
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        success(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure == nil) return ;
        failure(error);
    }];

}

+ (void)postUploadImagesVideosWithUrl:(NSString *)url imagesAndNames:(NSDictionary *)imageAndNames videoPaths:(NSDictionary *)videoPathAndNames parameters:(NSDictionary *)params success:(HttpSuccessBlock)success faillure:(HttpFailureBlock)failure {
    if (url == nil) url = @"";
    if (imageAndNames == nil) imageAndNames = @{};
    if (params == nil) params = @{};
    
    NSArray * imgKeyNames = [[imageAndNames allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult result = [obj1 compare:obj2 options:NSNumericSearch];
        
        return result == NSOrderedDescending;
    }];
    
    NSArray * videoKeyNames = [[videoPathAndNames allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult result = [obj1 compare:obj2 options:NSNumericSearch];
        
        return result == NSOrderedDescending;
    }];
    
    [[SNNetRequestManager shareRequestManager] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSInteger i = 0; i < imgKeyNames.count; i++) {
            
            NSString * keyN = imgKeyNames[i];
            
            NSString *suffix,*contentType;
            NSData * imageData;
            //判断图片是不是png格式的文件
            if (UIImagePNGRepresentation(imageAndNames[keyN])) {
                //返回为png图像。
                imageData = UIImagePNGRepresentation(imageAndNames[keyN]);
                suffix = @"png";
                contentType = @"image/png";
            }else {
                //返回为JPEG图像。
                imageData = UIImageJPEGRepresentation(imageAndNames[keyN], 1.0);
                suffix = @"jpg";
                contentType = @"image/jpeg";
            }
            
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy/MM/dd-HH:mm:ss"];
            NSString * appendStringToImageName = [formatter stringFromDate:[NSDate date]];
            NSString * imageName = [NSString stringWithFormat:@"iPhone_%ld%@.%@",(long)(i+10),appendStringToImageName,suffix];
            [formData appendPartWithFileData:imageData name:keyN fileName:imageName mimeType:contentType];
            
        }
        
        for (NSInteger i = 0; i < videoKeyNames.count; i++) {
            NSString * keyN = videoKeyNames[i];
            NSString * videoPath = videoPathAndNames[keyN];
            NSString * suffix = videoPath.pathExtension;
            if (!suffix.length) {
                suffix = @"mp4";
            }
            NSString * contentType = @"application/octet-stream";
            
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy/MM/dd-HH:mm:ss"];
            NSString * appendStringToVideoName = [formatter stringFromDate:[NSDate date]];
            NSString * videoName = [NSString stringWithFormat:@"iPhone_video%ld%@.%@",(long)(i+10),appendStringToVideoName,suffix];
            
            NSError * error = nil;
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:videoPath] name:keyN fileName:videoName mimeType:contentType error:&error];
            NSLog(@"videoUploadError:%@",error);
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success == nil) return ;
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        success(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure == nil) return ;
        failure(error);
    }];
}
//查看附件

+ (void)downloadWithUrl:(NSString *)strUrl
             andSuccess:(HttpSuccessBlock)success
             andFailure:(HttpFailureBlock)failure
{
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    NSString * urlString = strUrl;
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSString * cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString * path = [cacheDir stringByAppendingPathComponent:response.suggestedFilename];
        
        // URLWithString返回的是网络的URL,如果使用本地URL,需要注意
        //        NSURL *fileURL1 = [NSURL URLWithString:path];
        NSURL * fileURL = [NSURL fileURLWithPath:path];
        
        success(fileURL);
        
        return fileURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        failure(error);
    }];
    
    [task resume];

}

+ (void)checkTheUpdate:(NSString *)appID responseResult:(void (^)(NSString * URL,NSString * descriptionInfo, BOOL isUpdate))checkResultBlock {
    NSString * appStoreUrl = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@",appID];
    
    AFHTTPSessionManager * _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [_manager GET:appStoreUrl parameters:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        NSArray * arr = dic[@"results"];
        NSString * appStore_version = nil;
        NSString * trackViewUrl = nil;
        NSString * descriptionInfo = nil;
        if (arr.count) {
            for (NSDictionary * dict in arr) {
                appStore_version = dict[@"version"];
                trackViewUrl = dict[@"trackViewUrl"];
                descriptionInfo = dict[@"releaseNotes"];
            }
            NSString *version = [self infoPlistVersion];
            NSComparisonResult result = [version compare:appStore_version];
            if (result == NSOrderedAscending) {
                checkResultBlock(trackViewUrl,descriptionInfo,YES);
            } else {
                checkResultBlock(@"",@"暂无信息",NO);
            }
        } else {
            checkResultBlock(@"",@"暂无信息",NO);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        checkResultBlock(@"",[error localizedDescription],NO);
    }];
}

+ (NSString *)infoPlistVersion {
    NSString *version = nil;
    //    NSString *key = (NSString *)kCFBundleVersionKey; //build版本
    NSString *key = @"CFBundleShortVersionString"; //versiion版本
    //从Info.plist中取出版本号
    version = [NSBundle mainBundle].infoDictionary[key];
    return version;
}

@end
