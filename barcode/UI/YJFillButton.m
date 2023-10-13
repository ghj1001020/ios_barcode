//
//  YJFillButton.m
//  barcode
//
//  Created by 권혁준 on 2023/10/11.
//

#import "YJFillButton.h"

@implementation YJFillButton

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

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 코너 radius
    if(self.Radius > 0) {
        if(self.IsAllRadius) {
            self.layer.cornerRadius = self.Radius;
        }
        else {
            UIRectCorner maskCorner = 0;
            if(self.IsTopLeftRadius) {
                maskCorner |= UIRectCornerTopLeft;
            }
            if(self.IsTopRightRadius) {
                maskCorner |= UIRectCornerTopRight;
            }
            if(self.IsBottomLeftRadius) {
                maskCorner |= UIRectCornerBottomLeft;
            }
            if(self.IsBottomRightRadius) {
                maskCorner |= UIRectCornerBottomRight;
            }
            
            if(maskCorner != 0) {
                UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:maskCorner cornerRadii:CGSizeMake(self.Radius, self.Radius)];
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.frame = self.bounds;
                maskLayer.path = maskPath.CGPath;
                self.layer.mask = maskLayer;
            }
        }
    }
}

- (void) initUI {
    // 배경색
    if(self.BGColor == nil) {
        self.BGColor = [ColorUtil main];
    }
    [self setBackgroundColor:self.BGColor];
    
    // 글자색
    if(self.TextColor == nil) {
        self.TextColor = [UIColor whiteColor];
    }
    [self setTitleColor:self.TextColor forState:UIControlStateNormal];
}

@end
