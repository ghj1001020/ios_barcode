//
//  YJToast.h
//  barcode
//
//  Created by 권혁준 on 2023/10/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJToast : UIView
+ (void) showToast:(UIViewController *)vc Message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
