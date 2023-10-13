//
//  YJButton.m
//  barcode
//
//  Created by 권혁준 on 2023/10/11.
//

#import "YJButton.h"

@implementation YJButton

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
    [self setTitleColor:[ColorUtil text] forState:UIControlStateNormal];
    [self.layer setBorderWidth:1.0f];
    [self.layer setBorderColor:[UIColor blackColor].CGColor];
    
}


@end
