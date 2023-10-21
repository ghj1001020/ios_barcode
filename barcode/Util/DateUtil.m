//
//  DateUtil.m
//  barcode
//
//  Created by 권혁준 on 2023/10/21.
//

#import "DateUtil.h"

@implementation DateUtil

+ (NSString *)Today {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMddHHmmss"];
    NSString *today = [format stringFromDate:[NSDate date]];
    return today;
}

@end
