//
//  TestTableViewController.m
//  TableViewCellSelectDemo
//
//  Created by arbullzhang on 10/13/15.
//  Copyright © 2015 arbullzhang. All rights reserved.
//

#import "TestTableViewController.h"
#import "TestTableViewCell.h"
#import <FBKVOController.h>

@interface TestTableViewController ()

@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) UIButton *leftButton;
@property (nonatomic, assign) NSInteger selectedCellTotal;

@property (nonatomic, retain) FBKVOController *KVOController;

@end

@implementation TestTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"测试";
    
    self.dataArray = [[NSMutableArray alloc] init];
    for(NSInteger index = 0; index < 4; ++index)
    {
        TestCellItemModel *itemModel = [[TestCellItemModel alloc] init];
        itemModel.desc = [NSString stringWithFormat:@"测试：%ld", index];
        [self.dataArray addObject:itemModel];
    }
    
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 44)];
    self.leftButton.tag = 1;
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftButtonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.selectedCellTotal = 0;
    
    self.KVOController = [FBKVOController controllerWithObserver:self];
    [self.KVOController observe:self keyPath:@"selectedCellTotal" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        if([change[NSKeyValueChangeNewKey] integerValue] == 0)
        {
            [self.leftButton setTitle:@"全选" forState:UIControlStateNormal];
            self.leftButton.tag = 1;
        }
        else if([change[NSKeyValueChangeNewKey] integerValue] == self.dataArray.count)
        {
            [self.leftButton setTitle:@"取消全选" forState:UIControlStateNormal];
            self.leftButton.tag = 2;
        }
    }];
    
    //self.KVOController obse
}

- (void)leftButtonClickedAction:(id)sender
{
    UIButton *leftButton = (UIButton *)sender;
    BOOL checked = YES;
    if(leftButton.tag == 1)
    {
        leftButton.tag = 2;
        self.selectedCellTotal = self.dataArray.count;
    }
    else
    {
        leftButton.tag = 1;
        checked = NO;
        self.selectedCellTotal = 0;
    }
    
    for(NSInteger index = 0; index < self.dataArray.count; ++index)
    {
        TestTableViewCell *cell = (TestTableViewCell *)[self tableView:self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        TestCellItemModel *itemModel = [self.dataArray objectAtIndex:index];
        itemModel.checked = checked;
        [cell updateData:itemModel];
    }
    [self.tableView reloadData];
}


- (void)rightButtonClickedAction:(id)sender
{
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TestTableViewCellID"];
    cell.delegate = (id)self;
    [cell updateData:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - TestTableViewCellDelegate

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked itemModel:(TestCellItemModel *)itemModel
{
    itemModel.checked = checked;
    if(checked)
    {
        self.selectedCellTotal++;
    }
    else
    {
        self.selectedCellTotal--;
    }
}

@end
