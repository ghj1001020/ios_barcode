//
//  ImgScanViewController.h
//  barcode
//
//  Created by 권혁준 on 2023/09/09.
//


NS_ASSUME_NONNULL_BEGIN

@interface ImgScanViewController : BaseViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imgBarcode;
@property (strong, nonatomic) IBOutlet UILabel *lbBarcode;
@property (strong, nonatomic) IBOutlet UILabel *lbFilename;
@property (strong, nonatomic) IBOutlet UIView *layoutResult;

@end

NS_ASSUME_NONNULL_END
