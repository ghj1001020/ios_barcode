//
//  HistoryViewController.m
//  barcode
//
//  Created by 권혁준 on 2023/09/10.
//

#import "HistoryViewController.h"
#import "HistoryTableViewCell.h"
#import "YJSQLiteService.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController
{
    NSArray *mHistoryList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
    mHistoryList = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated {
    // 데이터조회
    mHistoryList = [YJSQLiteService dbSelectHistoryList];
    if([mHistoryList count] == 0) {
        [self.layoutEmptyData setHidden:NO];
        [self.tblHistory setHidden:YES];
    }
    else {
        [self.layoutEmptyData setHidden:YES];
        [self.tblHistory setHidden:NO];
    }
    [self.tblHistory reloadData];
}

- (void)initLayout {
    UINib *nib = [UINib nibWithNibName:@"HistoryTableViewCell" bundle:nil];
    [self.tblHistory registerNib:nib forCellReuseIdentifier:@"HistoryCell"];
    
    [self.tblHistory setDataSource:self];
    [self.tblHistory setDelegate:self];
    [self.tblHistory setHidden:YES];
    [self.layoutEmptyData setBackgroundColor:[ColorUtil background]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mHistoryList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryTableViewCell *cell = (HistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"HistoryCell"];
    HistoryData *data = [mHistoryList objectAtIndex:indexPath.row];
    [cell.lbDate setText:[DateUtil ConvertDateFormat:data.date :@"yyyyMMddHHmmss" :@"yyyy-MM-dd HH:mm:ss"]];
    [cell.lbBarcode setText:data.value];
    cell.onCopyClicked = ^{
        [YJToast showToast:self Message:@"클립보드에 복사 하였습니다."];
    };
    return cell;
}


@end
