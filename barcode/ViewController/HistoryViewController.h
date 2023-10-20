//
//  HistoryViewController.h
//  barcode
//
//  Created by 권혁준 on 2023/09/10.
//


NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet YJTableView *tblHistory;

@end

NS_ASSUME_NONNULL_END
