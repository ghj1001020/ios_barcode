//
//  DateUtil.m
//  barcode
//
//  Created by 권혁준 on 2023/10/21.
//

#import "DateUtil.h"

@implementation DateUtil

// 오늘날짜
+ (NSString *)Today {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMddHHmmss"];
    NSString *today = [format stringFromDate:[NSDate date]];
    return today;
}

// string 날짜 포맷 변경
+ (NSString *)ConvertDateFormat:(NSString *)src :(NSString *)srcFormat :(NSString *)dstFormat {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:srcFormat];
    NSDate *srcDate = [format dateFromString:src];
    [format setDateFormat:dstFormat];
    return [format stringFromDate:srcDate];
}

@end
