//
//  App.m
//  barcode
//
//  Created by 권혁준 on 2023/09/10.
//

#import "App.h"

@implementation App

// 앱종료
+ (void)close {
    [[UIApplication sharedApplication] performSelector:@selector(suspend)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        exit(0);
    });
}
@end
