//
//  YJTableView.m
//  barcode
//
//  Created by 권혁준 on 2023/10/19.
//

#import "YJTableView.h"

@implementation YJTableView

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

- (void)initUI {
    [self setAllowsSelection:NO];
    [self setSeparatorInset:UIEdgeInsetsMake(0, 16, 0, 16)];
    [self setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setSeparatorColor:[ColorUtil divider]];
}

@end
