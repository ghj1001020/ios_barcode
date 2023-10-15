//
//  YJImgButton.m
//  barcode
//
//  Created by 권혁준 on 2023/10/14.
//

#import "YJImgButton.h"

@implementation YJImgButton

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

}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 이미지
    [self setImage:self.Image forState:UIControlStateNormal];
    [self setImageEdgeInsets:UIEdgeInsetsMake(self.Padding, self.Padding, self.Padding, self.Padding)];
    
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
    
    // border
    if(self.BorderWidth > 0) {
        [self.layer setBorderWidth:self.BorderWidth];
        self.BorderColor = self.BorderColor == nil ? [ColorUtil border] : self.BorderColor;
        [self.layer setBorderColor:self.BorderColor.CGColor];
    }
}

@end
