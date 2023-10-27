//
//  DefineQuery.h
//  barcode
//
//  Created by 권혁준 on 2023/10/20.
//

#ifndef DefineQuery_h
#define DefineQuery_h

#define CREATE_HISTORY_TABLE (@"CREATE TABLE IF NOT EXISTS TBL_HISTORY ( \
                                    H_ID    INTEGER     PRIMARY KEY AUTOINCREMENT , \
                                    H_DATE  VARCHAR(14) NOT NULL, \
                                    H_VALUE TEXT        NOT NULL  \
                                );")

#define INSERT_HISTORY (@"INSERT INTO TBL_HISTORY (H_DATE, H_VALUE) \
                                           VALUES (?, ?)")

#define SELECT_HISTORY (@"SELECT   H_DATE, H_VALUE \
                          FROM     TBL_HISTORY \
                          ORDER BY H_ID DESC")

#endif /* DefineQuery_h */
