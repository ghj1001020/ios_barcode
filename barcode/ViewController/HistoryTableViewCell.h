//
//  HistoryTableViewCell.h
//  barcode
//
//  Created by 권혁준 on 2023/10/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbDate;
@property (strong, nonatomic) IBOutlet UILabel *lbBarcode;

// 복사클릭
@property (nonatomic, copy) void(^onCopyClicked)(void);

@end

NS_ASSUME_NONNULL_END
