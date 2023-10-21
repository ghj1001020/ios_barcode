//
//  YJSQLiteService.m
//  barcode
//
//  Created by 권혁준 on 2023/10/20.
//

#import "YJSQLiteService.h"

@implementation YJSQLiteService

// db파일 생성
+ (void)dbCreateHistoryTable {
    [[YJSQLite instance] open];
    [[YJSQLite instance] execSql:CREATE_HISTORY_TABLE :NULL];
    [[YJSQLite instance] close];
}

// 히스토리 데이터 인서트
+ (void)dbInsertHistory:(NSString *)value {
    [[YJSQLite instance] open];
    [[YJSQLite instance] execSql:INSERT_HISTORY :@[[DateUtil Today], value]];
    [[YJSQLite instance] close];
}

// 히스토리 결과 조회
+ (NSMutableArray *)dbSelectHistoryList {
    NSMutableArray *result = [NSMutableArray array];
    [[YJSQLite instance] open];
    [[YJSQLite instance] select:SELECT_HISTORY :NULL :^(sqlite3_stmt * _Nonnull stmt) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            sqlite3_column_text(stmt, 0);
            NSString *date = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 0)];
            NSString *value = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 1)];
            [result addObject:[[HistoryData alloc] init:date :value]];
        }
    }];
    [[YJSQLite instance] close];
    return result;
}

@end
