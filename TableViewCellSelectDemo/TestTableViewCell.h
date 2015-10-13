//
//  TestTableViewCell.h
//  TableViewCellSelectDemo
//
//  Created by arbullzhang on 10/13/15.
//  Copyright © 2015 arbullzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCheckBox.h"

@class TestCellItemModel;

@protocol TestTableViewCellDelegate <NSObject>

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked itemModel:(TestCellItemModel *)itemModel;

@end

@interface TestTableViewCell : UITableViewCell<QCheckBoxDelegate>

@property (nonatomic, retain) IBOutlet QCheckBox *checkBox;
@property (nonatomic, retain) IBOutlet UILabel *descLabel;
@property (nonatomic, assign) id<TestTableViewCellDelegate>delegate;

@property (nonatomic, retain) TestCellItemModel *itemModel;

- (void)updateData:(TestCellItemModel *)itemModel;

@end

//////////////////////////////////////////////////////////////////////////////
///

@interface TestCellItemModel : NSObject

@property (nonatomic, assign) BOOL checked;
@property (nonatomic, retain) NSString *desc;

@end
