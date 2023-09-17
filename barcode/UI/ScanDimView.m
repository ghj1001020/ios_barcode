//
//  ScanDimView.m
//  barcode
//
//  Created by 권혁준 on 2023/09/16.
//

#import "ScanDimView.h"

const CGFloat PADDING = 8;

@implementation ScanDimView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if(self) {
        [self setBackgroundColor:UIColor.blackColor];
        [self setAlpha:0.67];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setBackgroundColor:UIColor.blackColor];
        [self setAlpha:0.67];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat x = PADDING;
    CGFloat maskWidth = width - (2 * PADDING);
    CGFloat maskHeight = maskWidth;
    CGFloat y = (height - maskHeight) / 2;
        
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, maskWidth, maskHeight)];
    [path appendPath:maskPath];

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    [maskLayer setFrame:self.bounds];
    maskLayer.path = path.CGPath;
    [maskLayer setFillRule: kCAFillRuleEvenOdd];
    
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.path = maskPath.CGPath;
    [borderLayer setFillColor:UIColor.clearColor.CGColor];
    [borderLayer setStrokeColor:UIColor.whiteColor.CGColor];
    [borderLayer setLineWidth:3.0];

    self.layer.mask = maskLayer;
    [self.layer addSublayer:borderLayer];
}

@end
