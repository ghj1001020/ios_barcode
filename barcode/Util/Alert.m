//
//  Alert.m
//  barcode
//
//  Created by 권혁준 on 2023/09/10.
//

#import "Alert.h"

@implementation Alert
+ (void)showAlert:(NSString *)message {
    [self showAlert:@"" :message :NULL];
}

+ (void)showAlert:(NSString *)message :(void (^)(UIAlertAction * _Nonnull))handler {
    [self showAlert:@"" :message :handler];
}

+ (void)showAlert:(NSString *)title :(NSString *)message :(void (^)(UIAlertAction * action))handler {
    dispatch_async(dispatch_get_main_queue(), ^{
        __block UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.rootViewController = [[UIViewController alloc] init];
        window.windowLevel = UIWindowLevelAlert + 1;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(handler != NULL) {
                handler(action);
            }
            [window setHidden:YES];
        }];
        [alert addAction:action];
        
        [window makeKeyAndVisible];
        [window.rootViewController presentViewController:alert animated:YES completion:nil];
    });
}

@end
