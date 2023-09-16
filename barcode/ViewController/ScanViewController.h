//
//  ScanViewController.h
//  barcode
//
//  Created by 권혁준 on 2023/09/08.
//


NS_ASSUME_NONNULL_BEGIN

@interface ScanViewController : BaseViewController<AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) IBOutlet UIView *preview;

@end

NS_ASSUME_NONNULL_END
