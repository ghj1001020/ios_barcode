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

+ (UIColor *) text;
+ (UIColor *) placeHolder;
+ (UIColor *) dim;
+ (UIColor *) border;
+ (UIColor *) divider;
+ (UIColor *) background;
+ (UIColor *) bgTabBar;
@end

NS_ASSUME_NONNULL_END
