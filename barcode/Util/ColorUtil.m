//
//  Color.m
//  barcode
//
//  Created by 권혁준 on 2023/09/10.
//

#import "ColorUtil.h"

@implementation ColorUtil
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
+ (UIColor *)text {
    return [self colorByString:@"#1F1F1F"];
}
+ (UIColor *)placeHolder {
    return [self colorByString:@"#CCC"];
}
+ (UIColor *)dim {
    return [self colorByString:@"#000000" andAlpha:0.33f];
}
+ (UIColor *)border {
    return [self colorByString:@"#EFEFEF"];
}
+ (UIColor *)divider {
    return [self colorByString:@"#B4B4B3"];
}
+ (UIColor *)background {
    return [self colorByString:@"#FAFAFA"];
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
    
    if([rgb length] == 3) {
        rgb = [NSString stringWithFormat:@"%C%C%C%C%C%C", [rgb characterAtIndex:0], [rgb characterAtIndex:0], [rgb characterAtIndex:1], [rgb characterAtIndex:1], [rgb characterAtIndex:2], [rgb characterAtIndex:2]];
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
