//
//  GeneratorViewController.h
//  barcode
//
//  Created by 권혁준 on 2023/09/10.
//


NS_ASSUME_NONNULL_BEGIN

@interface GeneratorViewController : BaseViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *layoutInput;
@property (strong, nonatomic) IBOutlet UITextField *tfInput;
@property (strong, nonatomic) IBOutlet UIImageView *imgQRCode;

@end

NS_ASSUME_NONNULL_END
