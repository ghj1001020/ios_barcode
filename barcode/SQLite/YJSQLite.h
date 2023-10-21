#import <Foundation/Foundation.h>
#import <sqlite3.h>

NS_ASSUME_NONNULL_BEGIN
// DB파일 버전
#define DB_VERSION 1
// DB파일명
#define DB_FILE_NAME @"barcode.db"

@interface YJSQLite : NSObject
+(instancetype) instance;
-(BOOL) open;
-(void) close;
-(BOOL) execSql:(NSString *)sql :(nullable NSArray *)params;
-(void) select:(NSString *)sql :(nullable NSArray *)params :(void(^)(sqlite3_stmt* stmt))callback;

@end

NS_ASSUME_NONNULL_END
