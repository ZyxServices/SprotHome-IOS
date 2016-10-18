//
//  STNetWorkManger.m
//  STTools
//
//  Created by stoneobs on 16/10/9.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import "STNetWorkManger.h"
#import "AFNetworking.h"
@implementation STNetWorkManger
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr.requestSerializer setTimeoutInterval:10];
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
             success(responseObject);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
    
    
}
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer new];
    [mgr.requestSerializer setTimeoutInterval:10];
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)Delete:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
//公共上传图片接口 多张图片
+ (void)CommentPicWithDic:(NSDictionary *)dic//上传图片时可能有的附加条件如userid;
               withImages:(NSArray *)imageArray//存图片的字典
                  success:(void (^)(NSDictionary * dic))success
                    faile:(void (^)(NSError * error))faile
{
   // NSString *urlSring = [NSString stringWithFormat:@"%@%@",SERVERURL,@"/v1/uploads"];
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [mgr POST:@"urlstring" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSInteger i=1; i<=imageArray.count;i++ ) {
            UIImage * ima =imageArray[i-1];
            
            NSData * data =UIImageJPEGRepresentation(ima, 0.5);
            [formData appendPartWithFileData:data name:@"avatars" fileName:[NSString stringWithFormat:@"%ld.png",i] mimeType:@"image/png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * test =[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"成功%@",test);
       
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
  
        if (faile) {
            faile(error);
        }
        
    }];
}

//公共上传图片接口 1张图片

+ (void)commonUploadImage:(UIImage *)image
                  success:(void (^)(NSDictionary * dic))success
                    faile:(void (^)(NSError * error))faile {
    //NSString *urlSring = [NSString stringWithFormat:@"%@%@",SERVERURL,@"/v1/upload"];
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [mgr POST:@"urlSring" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //0.5
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:@"avatar" fileName:[NSString stringWithFormat:@"%@.png",@"avatar"] mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * test =[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (faile) {
            faile(error);
        }
        
    }];
}

@end
