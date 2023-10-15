//
//  YJLabel.m
//  barcode
//
//  Created by 권혁준 on 2023/10/08.
//

#import "YJLabel.h"

@implementation YJLabel

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
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(!self.CharacterSpacing) {
        self.CharacterSpacing = -0.5f;
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attr addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:self.CharacterSpacing] range:NSMakeRange(0, attr.length)];
    [self setAttributedText:attr];
    
    // 밑줄
    if(self.BottomWidth > 0) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.BottomWidth)];
        self.BottomColor = self.BottomColor == nil ? [UIColor blackColor] : self.BottomColor;
        [line setBackgroundColor:self.BottomColor];
        [self addSubview:line];
    }
}

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = UIEdgeInsetsMake(self.TopInset, self.LeftInset, self.BottomInset, self.RightInset);
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (CGSize)intrinsicContentSize {
    // 패딩 (글자 짤릴수 있음)
    CGSize size = [super intrinsicContentSize];
    return CGSizeMake(size.width + self.LeftInset + self.RightInset, size.height + self.TopInset + self.BottomInset);
}

@end
