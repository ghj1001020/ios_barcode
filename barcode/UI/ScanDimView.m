//
//  ScanDimView.m
//  barcode
//
//  Created by 권혁준 on 2023/09/16.
//

#import "ScanDimView.h"

@implementation ScanDimView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if(self) {
        [self setBackgroundColor:UIColor.blackColor];
        [self setAlpha:0.67];
    }
    return self;
}


@end
