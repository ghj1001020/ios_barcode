//
//  GeneratorViewController.m
//  barcode
//
//  Created by 권혁준 on 2023/09/10.
//

#import "GeneratorViewController.h"

@interface GeneratorViewController ()

@end

@implementation GeneratorViewController
{
    BOOL IsGenerated;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.layoutInput setBackgroundColor:[UIColor clearColor]];
    [self addGestureHideKeyboard];
    [self.tfInput setDelegate:self];
    [self initLayout];
}

- (void)initLayout {
    self->IsGenerated = NO;
    [self.tfInput setText:@""];
    [self.imgQRCode setImage:[UIImage imageNamed:@"no_image"]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.tfInput) {
        [textField resignFirstResponder];
        [self makeQRCode];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"textFieldDidEndEditing");
}

- (IBAction)onMakeQRCode:(UIButton *)sender {
    [self.tfInput endEditing:YES];
    [self makeQRCode];
}

// QR코드 생성
- (void)makeQRCode {
    NSString *value = [[self.tfInput text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if([value length] == 0) {
        [self initLayout];
        return;
    }
    
    NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    [filter setValue:data forKey:@"inputMessage"];
    
    CIImage *qrImage = [filter outputImage];
    [self.imgQRCode setImage:[UIImage imageWithCIImage:qrImage]];
    self->IsGenerated = YES;
}

// QR코드 이미지 저장
- (IBAction)onSaveQRImage:(UIButton *)sender {
    if(!self->IsGenerated) {
        return;
    }
    
    UIImage * img = [self.imgQRCode image];
    CGSize size = img.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, 1);
    UIImage *image = [UIImage imageWithCIImage:[self.imgQRCode image].CIImage];
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *qrcodeImage = UIGraphicsGetImageFromCurrentImageContext();
    NSData *data = UIImagePNGRepresentation(qrcodeImage);
    
    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:data], nil, nil, nil);
    UIGraphicsEndImageContext();
    
    [YJToast showToast:self Message:@"저장되었습니다"];
}

@end
