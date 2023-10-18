//
//  BaseViewController.m
//  barcode
//
//  Created by 권혁준 on 2023/09/08.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 스캔결과 팝업
- (void)showResultDialog:(NSString *)message CallBack:(void (^)(void))callback {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ResultDialog" bundle:nil];
    ResultDialog *dialog = [storyboard instantiateViewControllerWithIdentifier:@"resultDialog"];
    dialog.message = message;
    dialog.CallBack = callback;
    [dialog setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [self presentViewController:dialog animated:YES completion:nil];
}

// 키보드닫기 제스쳐 설정
- (void)addGestureHideKeyboard {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:tap];
}

// 키보드닫기
- (void)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}

@end
