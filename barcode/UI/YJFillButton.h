//
//  YJFillButton.h
//  barcode
//
//  Created by 권혁준 on 2023/10/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJFillButton : UIButton

// 코너 radius
@property (nonatomic) IBInspectable CGFloat Radius;
@property (nonatomic) IBInspectable BOOL IsAllRadius;
@property (nonatomic) IBInspectable BOOL IsTopLeftRadius;
@property (nonatomic) IBInspectable BOOL IsTopRightRadius;
@property (nonatomic) IBInspectable BOOL IsBottomLeftRadius;
@property (nonatomic) IBInspectable BOOL IsBottomRightRadius;


// 배경색
@property (nonatomic) IBInspectable UIColor *BGColor;

// 텍스트색
@property (nonatomic) IBInspectable UIColor *TextColor;


@end

NS_ASSUME_NONNULL_END
