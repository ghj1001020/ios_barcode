//
//  DateUtil.h
//  barcode
//
//  Created by 권혁준 on 2023/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateUtil : NSObject
+ (NSString *) Today;
+ (NSString *)ConvertDateFormat:(NSString *)src :(NSString *)srcFormat :(NSString *)dstFormat;

@end

NS_ASSUME_NONNULL_END
