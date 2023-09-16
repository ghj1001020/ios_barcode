//
//  Color.m
//  barcode
//
//  Created by 권혁준 on 2023/09/10.
//

#import "Color.h"

@implementation Color
+ (UIColor *)main {
    return [self colorByString:@"#0079FF"];
}
+ (UIColor *)green {
    return [self colorByString:@"#00DFA2"];
}
+ (UIColor *)yellow {
    return [self colorByString:@"#F6FA70"];
}
+ (UIColor *)red {
    return [self colorByString:@"#FF0060"];
}
+ (UIColor *)bgTabBar {
    return [self colorByString:@"#DDE6ED"];
}

// rgb string -> UIColor 로 변환
+ (UIColor *)colorByString:(NSString *)rgb {
    return [self colorByString:rgb andAlpha:1.0f];
}

// rgb string -> UIColor 로 변환
+ (UIColor *)colorByString:(NSString *)rgb andAlpha:(float)alpha {
    unsigned int value = 0;
    if( [rgb hasPrefix: @"#"] ) {
        rgb = [rgb stringByReplacingOccurrencesOfString: @"#" withString: @""];
    }
    
    // string -> hex int
    NSScanner *scanner = [NSScanner scannerWithString: rgb];
    [scanner scanHexInt: &value];
    
    float red = ((value & 0xFF0000) >> 16) / 255.0f;
    float green = ((value & 0x00FF00) >> 8) / 255.0f;
    float blue = (value & 0x0000FF) / 255.0f;
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}
@end
