//
//  YJImgButton.h
//  barcode
//
//  Created by 권혁준 on 2023/10/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJImgButton : UIButton
// 이미지
@property (nonatomic) IBInspectable UIImage *Image;
// 패딩
@property (nonatomic) IBInspectable CGFloat Padding;
// 코너 radius
@property (nonatomic) IBInspectable CGFloat Radius;
@property (nonatomic) IBInspectable BOOL IsAllRadius;
@property (nonatomic) IBInspectable BOOL IsTopLeftRadius;
@property (nonatomic) IBInspectable BOOL IsTopRightRadius;
@property (nonatomic) IBInspectable BOOL IsBottomLeftRadius;
@property (nonatomic) IBInspectable BOOL IsBottomRightRadius;
// border
@property (nonatomic) IBInspectable CGFloat BorderWidth;
@property (nonatomic) IBInspectable UIColor *BorderColor;

@end

NS_ASSUME_NONNULL_END
