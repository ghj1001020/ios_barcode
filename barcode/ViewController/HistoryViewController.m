//
//  HistoryViewController.m
//  barcode
//
//  Created by 권혁준 on 2023/09/10.
//

#import "HistoryViewController.h"
#import "HistoryTableViewCell.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
}

- (void)initLayout {
    UINib *nib = [UINib nibWithNibName:@"HistoryTableViewCell" bundle:nil];
    [self.tblHistory registerNib:nib forCellReuseIdentifier:@"HistoryCell"];
    
    [self.tblHistory setDataSource:self];
    [self.tblHistory setDelegate:self];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryTableViewCell *cell = (HistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"HistoryCell"];
    return cell;
}


@end
