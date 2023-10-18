//
//  YJTextField.m
//  barcode
//
//  Created by 권혁준 on 2023/10/16.
//

#import "YJTextField.h"

@implementation YJTextField


- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if(self) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self initUI];
    }
    return self;
}

- (void) initUI {
    [self setTextColor:[ColorUtil text]];
    [self setBackgroundColor:[UIColor clearColor]];
    [self.layer setCornerRadius:24];
    [self setReturnKeyType:UIReturnKeyDone];
    // 패딩
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
    [self setLeftView:leftView];
    [self setLeftViewMode:UITextFieldViewModeAlways];
}

@end
