//
//  STNetWorkManger.h
//  STTools
//
//  Created by stoneobs on 16/10/9.
//  Copyright © 2016年 stoneobs. All rights reserved.
// 管理afn 抽象出来的 工具类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface STNetWorkManger : NSObject
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

+ (void)Delete:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)CommentPicWithDic:(NSDictionary *)dic//上传图片时可能有的附加条件如userid;
               withImages:(NSArray *)imageArray//存图片的字典
                  success:(void (^)(NSDictionary * dic))success
                    faile:(void (^)(NSError * error))faile;

+ (void)commonUploadImage:(UIImage *)image
                  success:(void (^)(NSDictionary * dic))success
                    faile:(void (^)(NSError * error))faile ;
@end
