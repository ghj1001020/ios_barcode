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

-(void) showAlertView {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CustomAlertView" bundle:nil];
    CustomAlertView *alert = [storyboard instantiateViewControllerWithIdentifier:@"customAlert"];
    [alert setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
