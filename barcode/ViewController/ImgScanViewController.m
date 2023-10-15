//
//  ImgScanViewController.m
//  barcode
//
//  Created by 권혁준 on 2023/09/09.
//

#import "ImgScanViewController.h"
@import Photos;
@import PhotosUI;


@interface ImgScanViewController ()

@end

@implementation ImgScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[ColorUtil background]];
    [self.imgBarcode setBackgroundColor:[UIColor whiteColor]];
    [self.layoutResult setHidden:YES];
}

// 이미지 선택 피커
- (IBAction)onImagePicker:(UIButton *)sender {
    [self.imgBarcode setImage:nil];
    [self.lbBarcode setText:@""];
    [self.layoutResult setHidden:YES];
    [self.lbFilename setText:@""];
    
    if(@available(iOS 14, *)) {
//        PHPickerConfiguration *config = [[PHPickerConfiguration alloc] init];
        [self openUIImagePickerController];
    }
    else {
        [self openUIImagePickerController];
    }
}

// 바코드 복사
- (IBAction)onCopyClicked:(UIButton *)sender {
    
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


// UIImagePickerController 선택 콜백
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    PHAsset *asset = info[UIImagePickerControllerPHAsset];
    if(asset) {
        NSString *filename = [asset valueForKey:@"filename"];
        if(filename != nil)
            [self.lbBarcode setText:filename];
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        [self.imgBarcode setImage:image];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
