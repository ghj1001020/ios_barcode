//
//  YJSQLiteService.h
//  barcode
//
//  Created by 권혁준 on 2023/10/20.
//

#import "YJSQLite.h"
#import "DefineQuery.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJSQLiteService : NSObject

+ (void)dbCreateHistoryTable;
+ (void)dbInsertHistory:(NSString *)value;
+ (NSMutableArray *)dbSelectHistoryList;

@end

NS_ASSUME_NONNULL_END
