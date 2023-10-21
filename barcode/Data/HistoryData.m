//
//  HistoryData.m
//  barcode
//
//  Created by 권혁준 on 2023/10/21.
//

#import "HistoryData.h"

@implementation HistoryData

- (id)init:(NSString *)date :(NSString *)value {
    self = [super init];
    if(self) {
        self.date = date;
        self.value = value;
    }
    return self;
}


@end
