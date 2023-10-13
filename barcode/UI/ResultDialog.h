//
//  CustomAlertView.h
//  barcode
//
//  Created by 권혁준 on 2023/09/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResultDialog : UIViewController
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) void (^CallBack)(void);
@property (nonatomic, strong) IBOutlet UILabel *lbMessage;

@end

NS_ASSUME_NONNULL_END
