//
//  Color.h
//  barcode
//
//  Created by 권혁준 on 2023/09/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorUtil : NSObject
+ (UIColor *) colorByString:(NSString *)rgb;
+ (UIColor *) colorByString:(NSString *)rgb andAlpha:(float)alpha;

+ (UIColor *) main;
+ (UIColor *) green;
+ (UIColor *) yellow;
+ (UIColor *) red;
+ (UIColor *) bgTabBar;

+ (UIColor *) text;

@end

NS_ASSUME_NONNULL_END
