//
//  HistoryData.h
//  barcode
//
//  Created by 권혁준 on 2023/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryData : NSObject
@property NSString *date;
@property NSString *value;

- (id)init:(NSString *)date :(NSString *)value;
@end

NS_ASSUME_NONNULL_END
