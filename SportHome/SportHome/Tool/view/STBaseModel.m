//
//  XZBaseModel.m
//  SportClub
//
//  Created by stoneobs on 16/8/3.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//

#import "STBaseModel.h"
#import <objc/runtime.h>
@implementation STBaseModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
{
    
   // XZLog(@"%@中没有这个%@变量赋值失败",NSStringFromClass([self class]),key);
}
//字典转模型
-(id)initWithProperties:(NSDictionary*)properties {
    if(self =[self init]){
        if (![properties isKindOfClass:[NSDictionary class]]) {
            return self;
        }
        NSMutableDictionary *dic = [properties mutableCopy];
        //遍历排除nil
        for(NSString *keys in [[dic allKeys]mutableCopy]){
            NSObject *obj = [dic objectForKey:keys];
            if([obj isKindOfClass:[NSNull class]]){
//                [dic removeObjectForKey:keys];
                [dic setObject:@"" forKey:keys];
            }
        }
        
        NSObject *object = [properties objectForKey:@"id"];
        if(object){
            [dic removeObjectForKey:@"id"];
            [dic setObject:object forKey:@"ID"];
        }
        for(NSString *keys in [dic allKeys]){
            NSObject *obj = [dic objectForKey:keys];
            if(!obj){
                obj = [[NSObject alloc]init];
                [dic setValue:obj forKey:keys];
            }
        }
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
//模型转字典
- (id)intWithModel:(id)model
{
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([model class], &outCount);
    
    NSMutableArray *array =[NSMutableArray array];
    for(i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        
        fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
        [array addObject:[NSString stringWithFormat:@"%s",property_getName(property)]];
    }
    NSMutableDictionary *dic =  [[model dictionaryWithValuesForKeys:array] mutableCopy];
    //遍历排除nil
    for(NSString *keys in [[dic allKeys]mutableCopy]){
        NSObject *obj = [dic objectForKey:keys];
        if([obj isKindOfClass:[NSNull class]]){
            [dic removeObjectForKey:keys];
        }
    }
    return dic;
}


@end
