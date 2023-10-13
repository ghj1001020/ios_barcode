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

- (void)showResultDialog:(NSString *)message CallBack:(void (^)(void))callback {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ResultDialog" bundle:nil];
    ResultDialog *dialog = [storyboard instantiateViewControllerWithIdentifier:@"resultDialog"];
    dialog.message = message;
    dialog.CallBack = callback;
    [dialog setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [self presentViewController:dialog animated:YES completion:nil];

}

@end
