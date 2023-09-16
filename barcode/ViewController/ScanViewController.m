//
//  ScanViewController.m
//  barcode
//
//  Created by 권혁준 on 2023/09/08.
//

#import "ScanViewController.h"
#import "ScanDimView.h"

@interface ScanViewController ()

@end

@implementation ScanViewController
{
    AVCaptureSession *mCaptureSession;
    AVCaptureDevice *mCaptureDevice;
    AVCaptureVideoPreviewLayer *mPreviewLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [self checkPermission];
}

- (void) checkPermission {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    // 카메라 접근 권한 동의
    if(status == AVAuthorizationStatusAuthorized) {
        [self initCamera];
    }
    // 카메라 접근 권한 거부
    else if(status == AVAuthorizationStatusDenied) {
        [Alert showAlert:@"카메라 사용 권한이 없습니다" :^(UIAlertAction * _Nonnull action) {
            [App close];
        }];
    }
    // 카메라 접근 권한 동의전
    else if(status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self initCamera];
                });
            }
            else {
                [Alert showAlert:@"카메라 사용 권한이 없습니다" :^(UIAlertAction * _Nonnull action) {
                    [App close];
                }];
            }
        }];
    }
    // 카메라 제한
    else if(status == AVAuthorizationStatusRestricted) {
        [Alert showAlert:@"카메라를 사용하실 수 없습니다" :^(UIAlertAction * _Nonnull action) {
            [App close];
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    if(mCaptureSession != nil && [mCaptureSession isRunning]) {
        [mCaptureSession stopRunning];
    }
    if(mPreviewLayer != nil) {
        [mPreviewLayer removeFromSuperlayer];
    }
}

- (void) initCamera {
    // 카메라 작동시킬 세션 초기화
    mCaptureSession = [[AVCaptureSession alloc] init];
    [mCaptureSession beginConfiguration];
    
    // 디바이스 설정
    mCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [mCaptureDevice lockForConfiguration:nil];
    [mCaptureDevice setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
    [mCaptureDevice unlockForConfiguration];
    
    // 비디오캡쳐 입력 설정
    NSError *error;
    AVCaptureDeviceInput *captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:mCaptureDevice error:&error];
    if(error) {
        [Alert showAlert:[NSString stringWithFormat:@"카메라 설정 에러 : %@", error.userInfo] :^(UIAlertAction * _Nonnull action) {
            [App close];
        }];
        return;
    }
    // 카메라 세션에 입력을 담당하는 AVCaptureDeviceInput 넣어줌
    [mCaptureSession addInput:captureDeviceInput];
    
    // 바코드데이터 캡쳐 설정
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [mCaptureSession addOutput:captureMetadataOutput];
    // 바코드데이터 스캔 델리게이트
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [captureMetadataOutput setMetadataObjectTypes:[captureMetadataOutput availableMetadataObjectTypes]];
    
    // 프리뷰화면을 카메라세션으로 초기화
    mPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:mCaptureSession];
    // 프리뷰화면의 사이즈 조절
    [mPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    // 프리뷰레이어에 프레임 설정
    [mPreviewLayer setFrame:self.preview.layer.bounds];
    
    CALayer *caLayer = [self.preview layer];
    caLayer.masksToBounds = true;
    
    [self.preview.layer addSublayer:mPreviewLayer];

    // 세션시작
    [mCaptureSession commitConfiguration];
    [mCaptureSession startRunning];
}

// 바코드 캡쳐 콜백
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    CGRect highlightRect = CGRectZero;
    NSString *barcode = nil;
    NSArray *supportedBarcodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Mod43Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
    
    for (AVMetadataObject *barcodeMetadata in metadataObjects) {
        for(NSString *supportedBarcode in supportedBarcodeTypes) {
            if([supportedBarcode isEqual:barcodeMetadata.type]) {
                AVMetadataMachineReadableCodeObject *barcodeObject = (AVMetadataMachineReadableCodeObject *)[mPreviewLayer transformedMetadataObjectForMetadataObject:barcodeMetadata];
                barcode = [barcodeObject stringValue];
                highlightRect = barcodeObject.bounds;
                NSLog(@"스캔 결과 : %@", barcode);
                break;
            }
        }
    }
    
    // 값 추출해서 화면 종료
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{

    });
}


@end
