//
//  ImgScanViewController.m
//  barcode
//
//  Created by 권혁준 on 2023/09/09.
//

#import "ImgScanViewController.h"



@interface ImgScanViewController ()

@end

@implementation ImgScanViewController
{
    NSString *barcode;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[ColorUtil background]];
    [self.imgBarcode setBackgroundColor:[UIColor whiteColor]];
    [self initLayout];
}

-(void) initLayout {
    self->barcode = @"";
    [self.imgBarcode setImage:[UIImage imageNamed:@"no_image"]];
    [self.lbBarcode setText:@"바코드 결과"];
    [self.lbBarcode setTextColor:[ColorUtil placeHolder]];
    [self.lbFilename setText:@"파일명"];
    [self.lbFilename setTextColor:[ColorUtil placeHolder]];
}

// 이미지 선택 피커
- (IBAction)onImagePicker:(UIButton *)sender {
    [self initLayout];
    
    if(@available(iOS 14, *)) {
        [self openPHPickerViewController];
    }
    else {
        [self openUIImagePickerController];
    }
}

// 바코드 복사
- (IBAction)onCopyClicked:(UIButton *)sender {
    if([self->barcode length] == 0) {
        return;
    }
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self->barcode;
    
    [YJToast showToast:self Message:@"클립보드에 복사 하였습니다."];
}

// UIImagePickerController 사용
-(void) openUIImagePickerController {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if(status == PHAuthorizationStatusAuthorized) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [picker setAllowsEditing:NO];
            [picker setDelegate:self];
            [self presentViewController:picker animated:YES completion:nil];

        });
    }
    else if(status == PHAuthorizationStatusNotDetermined){
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if(status == PHAuthorizationStatusAuthorized) {
                [self openUIImagePickerController];
            }
            else {
                [Alert showAlert:@"갤러리 접근 권한이 없습니다"];
            }
        }];
    }
    else if(status == PHAuthorizationStatusDenied) {
        [Alert showAlert:@"갤러리 접근 권한이 없습니다"];
    }
    else if(status == PHAuthorizationStatusRestricted) {
        [Alert showAlert:@"갤러리를 사용하실 수 없습니다"];
    }
}

// PHPickerViewController
-(void) openPHPickerViewController {
    if(@available(iOS 14, *)) {
        PHPickerConfiguration *config = [[PHPickerConfiguration alloc] initWithPhotoLibrary:PHPhotoLibrary.sharedPhotoLibrary];
        [config setSelectionLimit:1];
        [config setFilter:[PHPickerFilter anyFilterMatchingSubfilters:@[[PHPickerFilter imagesFilter]]]];
        PHPickerViewController *picker = [[PHPickerViewController alloc] initWithConfiguration:config];
        [picker setDelegate:self];
        [self presentViewController:picker animated:YES completion:nil];
    }
}

// UIImagePickerController 선택 콜백
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    PHAsset *asset = info[UIImagePickerControllerPHAsset];
    if(asset) {
        NSString *filename = [asset valueForKey:@"filename"];
        if(filename != nil) {
            [self.lbFilename setText:filename];
            [self.lbFilename setTextColor:[ColorUtil text]];
        }
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        [self.imgBarcode setImage:image];
        self->barcode = [self detectBarcodeImage:image];
        [self.lbBarcode setText:self->barcode];
        [self.lbBarcode setTextColor:[ColorUtil text]];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// PHPickerViewController 선택 콜백
- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results  API_AVAILABLE(ios(14)){
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    PHPickerResult *result = [results firstObject];
    if(result.itemProvider && [result.itemProvider canLoadObjectOfClass:UIImage.class]) {
        // 이미지로드
        [result.itemProvider loadObjectOfClass:UIImage.class completionHandler:^(UIImage *image, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.imgBarcode setImage:image];
                self->barcode = [self detectBarcodeImage:image];
                [self.lbBarcode setText:self->barcode];
                [self.lbBarcode setTextColor:[ColorUtil text]];
            });
        }];
        // 이미지파일명
        [result.itemProvider loadFileRepresentationForTypeIdentifier:@"public.image" completionHandler:^(NSURL * _Nullable url, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *filename = [url lastPathComponent];
                [self.lbFilename setText:filename];
                [self.lbFilename setTextColor:[ColorUtil text]];
            });
        }];
    }
}

// QR/바코드 이미지 읽기
- (NSString *) detectBarcodeImage:(UIImage *) image {
    if(!image) return @"";
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIContext *ciContext = [CIContext context];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:ciContext options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    NSArray *features = [detector featuresInImage:ciImage];
    
    if(features == nil || [features count] == 0) {
        return @"";
    }
    
    NSString *text = @"";
    for (CIQRCodeFeature *feature in features) {
        text = [feature messageString];
    }
    return text;
}

@end
