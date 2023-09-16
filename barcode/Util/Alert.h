//
//  Alert.h
//  barcode
//
//  Created by 권혁준 on 2023/09/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Alert : NSObject
+ (void) showAlert:(NSString *)message;
+ (void) showAlert:(NSString *)message :(nullable void (^)(UIAlertAction *action))handler;
+ (void) showAlert:(NSString *)title :(NSString *)message :(nullable void (^)(UIAlertAction *action))handler;

@end

NS_ASSUME_NONNULL_END
