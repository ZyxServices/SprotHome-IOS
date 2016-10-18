//
//  XZBaseModel.h
//  SportClub
//
//  Created by stoneobs on 16/8/3.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STBaseModel : NSObject
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
-(id)initWithProperties:(NSDictionary*)properties;
@end
