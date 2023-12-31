//
//  BaseViewController.h
//  barcode
//
//  Created by 권혁준 on 2023/09/08.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
-(void) showResultDialog:(NSString *)message CallBack:(void(^)(void))callback;
-(void) addGestureHideKeyboard;
@end

NS_ASSUME_NONNULL_END
