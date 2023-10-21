//
//  AppDelegate.m
//  barcode
//
//  Created by 권혁준 on 2023/09/05.
//

#import "AppDelegate.h"
#import "YJSQLiteService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    // 탭바 컨트롤러를 루트로 시작
    UINavigationController *rootNavi = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"rootNavi"];
    [self.window setRootViewController:rootNavi];
    
    // KeyWindow : window가 여러개일때 가장 앞쪽에 배치된 윈도우
    [self.window makeKeyAndVisible];
    
    // db 파일생성
    [YJSQLiteService dbCreateHistoryTable];

    return YES;
}

@end
