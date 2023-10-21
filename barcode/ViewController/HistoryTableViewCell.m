//
//  HistoryTableViewCell.m
//  barcode
//
//  Created by 권혁준 on 2023/10/19.
//

#import "HistoryTableViewCell.h"

@implementation HistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
}

- (IBAction)onCopyClicked:(UIButton *)sender {
    if([[self.lbBarcode text] length] == 0) {
        return;
    }
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = [self.lbBarcode text];
    
    self.onCopyClicked();
}

@end
