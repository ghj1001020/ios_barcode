//
//  YJToast.m
//  barcode
//
//  Created by 권혁준 on 2023/10/13.
//

#import "YJToast.h"

@implementation YJToast
+ (void)showToast:(UIViewController *)vc Message:(NSString *)message {
    CGRect mainBounds = UIScreen.mainScreen.bounds;
    CGFloat toastPadding = 24;
    CGFloat toastBottomMargin = 20;
    CGFloat transitionY = 25;

    // 토스트 폰트
    UIFont *font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];

    // 텍스트
    UILabel *textLabel = [[UILabel alloc] init];
    [textLabel setText:message];
    [textLabel setFont:font];
    CGSize textSize = textLabel.attributedText.size;

    // 토스트 크기
    CGFloat toastWidth = textSize.width + toastPadding;
    toastWidth = MAX(toastWidth, 48);
    CGFloat toastHeight = textSize.height + toastPadding;
    toastHeight = MAX(toastHeight, 48);
    CGRect toastRect = CGRectMake(mainBounds.size.width/2 - toastWidth/2, mainBounds.size.height - toastHeight - transitionY - toastBottomMargin, toastWidth, toastHeight);
    
    // 토스트
    __block UILabel *toastLabel = [[UILabel alloc] initWithFrame:toastRect];
    [toastLabel setNumberOfLines:0];
    // 배경색
    [toastLabel setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.67]];
    // 텍스트
    [toastLabel setText:message];
    [toastLabel setTextColor:[UIColor whiteColor]];
    [toastLabel setFont:font];
    [toastLabel setTextAlignment:NSTextAlignmentCenter];
    // round
    [toastLabel setClipsToBounds:YES];
    [toastLabel.layer setCornerRadius:24];
    // border
    [toastLabel.layer setBorderColor:[UIColor clearColor].CGColor];
    [toastLabel.layer setBorderWidth:0];
    
    // viewcontroller에 추가
    [vc.view addSubview:toastLabel];
    
    // animation
    [toastLabel setAlpha:0.0];
    CGRect transitionRect = CGRectMake(toastRect.origin.x, toastRect.origin.y + transitionY, toastRect.size.width, toastRect.size.height);
    
    // 위에서 아래로 나타나는 애니메이션
    [UIView animateWithDuration:0.5 animations:^{
        [toastLabel setAlpha:1.0];
        [toastLabel setFrame:transitionRect];
    } completion:^(BOOL finished) {
        // 2초동안 보여짐
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 사라지는 애니메이션
            [UIView animateWithDuration:0.5 animations:^{
                [toastLabel setAlpha:0.0];
                [toastLabel setTransform:CGAffineTransformMakeScale(0.01, 0.01)];
            } completion:^(BOOL finished) {
                [toastLabel removeFromSuperview];
                toastLabel = nil;
            }];
        });
    }];
}

@end
