//
//  MainViewController.m
//  barcode
//
//  Created by 권혁준 on 2023/09/08.
//

#import "MainViewController.h"
#import "ScanViewController.h"
#import "ImgScanViewController.h"
#import "GeneratorViewController.h"
#import "HistoryViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize tabBar = _tabBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabBar];
}

-(void) initTabBar {
    self.tabBar = [[ESTabBarController alloc] initWithTabIconNames:@[@"ic_scan", @"ic_imgscan", @"ic_generator", @"ic_history"]];
    [self.tabBar setViewController:[[ScanViewController alloc] init] atIndex:0];
    [self.tabBar setViewController:[[ImgScanViewController alloc] init] atIndex:1];
    [self.tabBar setViewController:[[GeneratorViewController alloc] init] atIndex:2];
    [self.tabBar setViewController:[[HistoryViewController alloc] init] atIndex:3];
    
    [self.tabBar setAction:^{
        
    } atIndex:0];
    [self.tabBar setAction:^{
        
    } atIndex:1];
    [self.tabBar setAction:^{
        
    } atIndex:2];
    [self.tabBar setAction:^{
        
    } atIndex:3];
    
    [self.tabBar setSelectedColor:[Color red]];
    [self.tabBar setButtonsBackgroundColor:[Color bgTabBar]];
    [self addChildViewController:self.tabBar];
    [self.view addSubview:self.tabBar.view];
    self.tabBar.view.frame = self.view.bounds;
}

@end
