//
//  ScanViewController.m
//  barcode
//
//  Created by 권혁준 on 2023/09/08.
//

#import "ScanViewController.h"
#import "ScanDimView.h"
#import "YJSQLiteService.h"

@interface ScanViewController ()

@end

@implementation ScanViewController
{
    AVCaptureSession *mCaptureSession;
    AVCaptureDevice *mCaptureDevice;
    AVCaptureVideoPreviewLayer *mPreviewLayer;
    // 스캔된 영역
    UIView *scanArea;
    // 캡쳐완료여부
    BOOL isCaptured;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isCaptured = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"viewDidAppear");
    [self checkPermission];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPause) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onResume) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self destroyCamera];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(void) onPause {
    NSLog(@"onPause");
    if(!isCaptured) {
        [self stopCamera];
    }
}

-(void) onResume {
    NSLog(@"onResume");
    if(!isCaptured) {
        [self startCamera];
    }
}

- (void) checkPermission {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    // 카메라 접근 권한 동의
    if(status == AVAuthorizationStatusAuthorized) {
        [self initCamera];
    }
    // 카메라 접근 권한 거부
    else if(status == AVAuthorizationStatusDenied) {
        [AlertUtil showAlert:@"카메라 사용 권한이 없습니다" :^(UIAlertAction * _Nonnull action) {
            [AppUtil close];
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
                [AlertUtil showAlert:@"카메라 사용 권한이 없습니다" :^(UIAlertAction * _Nonnull action) {
                    [AppUtil close];
                }];
            }
        }];
    }
    // 카메라 제한
    else if(status == AVAuthorizationStatusRestricted) {
        [AlertUtil showAlert:@"카메라를 사용하실 수 없습니다" :^(UIAlertAction * _Nonnull action) {
            [AppUtil close];
        }];
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
        [AlertUtil showAlert:[NSString stringWithFormat:@"카메라 설정 에러 : %@", error.userInfo] :^(UIAlertAction * _Nonnull action) {
            [AppUtil close];
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
    
    // 스캔된 영역
    scanArea = [[UIView alloc] init];
    [scanArea setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:0.15]];
    [scanArea.layer setBorderColor:UIColor.redColor.CGColor];
    [scanArea.layer setBorderWidth:3.0];
    [self.preview addSubview:scanArea];
}

-(void) startCamera {
    if(mCaptureSession != nil && [mCaptureSession isRunning]) {
        [[mPreviewLayer connection] setEnabled:YES];
    }
}

-(void) stopCamera {
    if(mCaptureSession != nil && [mCaptureSession isRunning]) {
        [[mPreviewLayer connection] setEnabled:NO];
    }
}

-(void) destroyCamera {
    if(mCaptureSession != nil && [mCaptureSession isRunning]) {
        [mCaptureSession stopRunning];
    }
    if(mPreviewLayer != nil) {
        [mPreviewLayer removeFromSuperlayer];
    }
}

// 바코드 캡쳐 콜백
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if(![[mPreviewLayer connection] isEnabled]) {
        return;
    }
    @synchronized (self) {
        isCaptured = YES;
        [self stopCamera];
        
        AVMetadataMachineReadableCodeObject *barcode;
        NSArray *supportedBarcodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Mod43Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
        
        for (AVMetadataObject *barcodeMetadata in metadataObjects) {
            for(NSString *supportedBarcode in supportedBarcodeTypes) {
                if([supportedBarcode isEqual:barcodeMetadata.type]) {
                    AVMetadataMachineReadableCodeObject *barcodeObject = (AVMetadataMachineReadableCodeObject *)[mPreviewLayer transformedMetadataObjectForMetadataObject:barcodeMetadata];
                    barcode = barcodeObject;
                    break;
                }
            }
            if(barcode != nil)
                break;
        }

        if(barcode) {
            NSString *value = [barcode stringValue];
            // 데이터 저장
            [YJSQLiteService dbInsertHistory:value];
            NSLog(@"Scan : %@", value);
            [scanArea setFrame:barcode.bounds];
            
            [self showResultDialog:value CallBack:^{
                [self->scanArea setFrame:CGRectMake(0, 0, 0, 0)];
                [self startCamera];
                self->isCaptured = NO;
            }];
        }
    }
}

@end
