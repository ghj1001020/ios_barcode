#import "YJSQLite.h"

@implementation YJSQLite
{
    sqlite3 *db;
    NSString *dbPath;
}

+(instancetype) instance {
    static dispatch_once_t predicate = 0;
    static YJSQLite *_object = nil;
    dispatch_once(&predicate, ^{
        _object = [[YJSQLite alloc] init];
    });
    return _object;
}

-(BOOL) open {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    dbPath = [documentPath stringByAppendingPathComponent:DB_FILE_NAME];
    NSLog(@"dbPath : %@", dbPath);
    
    if(sqlite3_open([dbPath cStringUsingEncoding:NSUTF8StringEncoding], &self->db) != SQLITE_OK) {
        NSLog(@"SQLITE Open Failed");
        return NO;
    }
    return YES;
}

-(void) close {
    if(self->db != nil) {
        sqlite3_close(self->db);
    }
    self->db = nil;
}

-(BOOL) execSql:(NSString *)sql :(NSArray *)params {
    if(!db) {
        NSLog(@"DB is nil");
        return NO;
    }
    
    BOOL result = NO;
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        // 바인딩
        if(params != NULL) {
            for( int i=0; i<params.count; i++) {
                id item = params[i];
                if([item isKindOfClass:[NSNumber class]]) {
                    if(strcmp([item objCType], @encode(int)) == 0) {
                        sqlite3_bind_int(stmt, i+1, [item intValue]);
                    }
                    else {
                        sqlite3_bind_double(stmt, i+1, [item doubleValue]);
                    }
                }
                else {
                    sqlite3_bind_text(stmt, i+1, [item UTF8String], -1, SQLITE_TRANSIENT);
                }
            }
        }

        // 정상
        if(sqlite3_step(stmt) == SQLITE_DONE) {
            result = YES;
        }
    }
    
    // 예외발생
    if(!result) {
        NSInteger errCode = sqlite3_errcode(self->db);
        NSString *errMsg = [NSString stringWithUTF8String:sqlite3_errmsg(self->db)];
        NSLog(@"SQLite Execute Failed. [%ld]%@", errCode, errMsg);
    }

    sqlite3_finalize(stmt);
    
    return result;
}

-(void) select:(NSString *)sql :(NSArray *)params :(void(^)(sqlite3_stmt* stmt))callback {
    if(!db) {
        NSLog(@"DB is nil");
        return;
    }
    
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        // 바인딩
        if(params != NULL) {
            for (int i=0; i<params.count; i++) {
                id item = params[i];
                if([item isKindOfClass:[NSNumber class]]) {
                    if(strcmp([item objCType], @encode(int)) == 0) {
                        sqlite3_bind_int(stmt, i+1, [item intValue]);
                    }
                    else {
                        sqlite3_bind_double(stmt, i+1, [item doubleValue]);
                    }
                }
                else {
                    sqlite3_bind_text(stmt, i+1, [item UTF8String], -1, SQLITE_TRANSIENT);
                }
            }
        }
        
        callback(stmt);
        sqlite3_finalize(stmt);
    }
    else {
        NSInteger errCode = sqlite3_errcode(self->db);
        NSString *errMsg = [NSString stringWithUTF8String:sqlite3_errmsg(self->db)];
        NSLog(@"SQLite Select Failed. [%ld]%@", errCode, errMsg);
    }
}

@end
