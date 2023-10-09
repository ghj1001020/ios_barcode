//
//  YJLabel.h
//  barcode
//
//  Created by 권혁준 on 2023/10/08.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface YJLabel : UILabel
@property (nonatomic) IBInspectable CGFloat TopInset;
@property (nonatomic) IBInspectable CGFloat LeftInset;
@property (nonatomic) IBInspectable CGFloat BottomInset;
@property (nonatomic) IBInspectable CGFloat RightInset;

@property (nonatomic) IBInspectable CGFloat CharacterSpacing;

@end

NS_ASSUME_NONNULL_END
