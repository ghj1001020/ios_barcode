//
//  CustomAlertView.m
//  barcode
//
//  Created by 권혁준 on 2023/09/17.
//

#import "ResultDialog.h"

@interface ResultDialog ()

@end

@implementation ResultDialog

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[ColorUtil dim]];
    [self.lbMessage setText:self.message];
}

- (IBAction)onCopyClicked:(UIButton *)sender {
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self.message;
    
    [YJToast showToast:self Message:@"클립보드에 복사 하였습니다."];
}

// 확인 버튼 클릭
- (IBAction)onOkClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if(self.CallBack != nil) {
        self.CallBack();
    }
}

@end
