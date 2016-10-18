//
//  NSDate+Formatter.h
//  SystemXinDai
//
//  Created by stoneobs on 16/3/26.
//  Copyright © 2016年 stoneobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Formatter)

+(NSDate *)yesterday;

+(NSDateFormatter *)formatter;
+(NSDateFormatter *)formatterWithoutTime;
+(NSDateFormatter *)formatterWithoutDate;

-(NSString *)formatWithUTCTimeZone;
-(NSString *)formatWithLocalTimeZone;
-(NSString *)formatWithTimeZoneOffset:(NSTimeInterval)offset;
-(NSString *)formatWithTimeZone:(NSTimeZone *)timezone;

-(NSString *)formatWithUTCTimeZoneWithoutTime;
-(NSString *)formatWithLocalTimeZoneWithoutTime;
-(NSString *)formatWithTimeZoneOffsetWithoutTime:(NSTimeInterval)offset;
-(NSString *)formatWithTimeZoneWithoutTime:(NSTimeZone *)timezone;

-(NSString *)formatWithUTCWithoutDate;
-(NSString *)formatWithLocalTimeWithoutDate;
-(NSString *)formatWithTimeZoneOffsetWithoutDate:(NSTimeInterval)offset;
-(NSString *)formatTimeWithTimeZone:(NSTimeZone *)timezone;


+ (NSString *)currentDateStringWithFormat:(NSString *)format;
+ (NSDate *)dateWithSecondsFromNow:(NSInteger)seconds;
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day;
- (NSString *)dateWithFormat:(NSString *)format;

//Other
+(NSDate*)localCurrentDate;//本地当前时间
-(NSDate*)localDate;//本地时间
- (NSString *)mmddByLineWithDate;
- (NSString *)yyyyMMByLineWithDate;
- (NSString *)yyyyMMddByLineWithDate;
- (NSString *)mmddChineseWithDate;
- (NSString *)hhmmssWithDate;
- (NSString *)yyyyMMddhhmmssWithDate;
- (NSString *)morningOrAfterWithHH;
- (NSString *)weekOrMonth;//本周，本月，几时几分---调用者用本地时间，

@end
