//
//  TestTableViewCell.m
//  TableViewCellSelectDemo
//
//  Created by arbullzhang on 10/13/15.
//  Copyright © 2015 arbullzhang. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell

- (void)awakeFromNib
{
    self.checkBox.delegate = self;
}

#pragma mark - QCheckBoxDelegate

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    NSLog(@"did tap on CheckBox:%@ checked:%d", checkbox.titleLabel.text, checked);
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedCheckBox:checked:itemModel:)])
    {
        [self.delegate didSelectedCheckBox:checkbox checked:checked itemModel:self.itemModel];
    }
}

- (void)updateData:(TestCellItemModel *)itemModel
{
    self.itemModel = itemModel;
    
    self.checkBox.checked = itemModel.checked;
    self.descLabel.text = itemModel.desc;
}

@end

////////////////////////////////////////////////////////////////////

@implementation TestCellItemModel

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.checked = NO;
    }
    return self;
}

@end
