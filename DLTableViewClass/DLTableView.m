//
//  DLTableView.m
//  DLTableView
//
//  Created by XueYulun on 15/4/12.
//  Copyright (c) 2015年 DL. All rights reserved.
//

#import "DLTableView.h"

#define DL_INLINE static inline

@interface DLTableView () {
    
    CGRect _frame;
    UITableViewStyle _style;
    NSString * _CellIdentifier;
}

@end

@implementation DLTableView

static DLTableView * tableView;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        tableView = self;
        _frame = frame;
        _style = style;
        _tableView = [[UITableView alloc] initWithFrame:_frame style:_style];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [self LayoutMyView];
    [self BindDelegate];
}

- (void)LayoutMyView {
    
    [self addSubview:_tableView];
}

- (void)BindDelegate {
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)BindDelegateTo: (id)object {
    
    _tableView.delegate = object;
    _tableView.dataSource = object;
}

- (void)setFullHorizontalSeparateLine:(BOOL)FullHorizontalSeparateLine {
    
    if (FullHorizontalSeparateLine) {
        
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    _FullHorizontalSeparateLine = FullHorizontalSeparateLine;
}

- (void)setTBGColor:(UIColor *)TBGColor {
    
    _tableView.backgroundColor = TBGColor;
    _TBGColor = TBGColor;
}

- (void)setBGView:(UIView *)BGView {
    
    _tableView.backgroundView = BGView;
    _BGView = BGView;
}

- (void)setIdentifier:(NSString *)identifier {
    
    _CellIdentifier = identifier;
    _identifier = identifier;
}

- (void)setCellClass:(Class)cellClass {
    
    NSAssert(_CellIdentifier, @"Without Cell Identifier.");
    [_tableView registerClass:cellClass forCellReuseIdentifier:_CellIdentifier];
    _cellClass = cellClass;
}

- (void)setHideUncalledCell:(BOOL)HideUncalledCell {
    
    _tableView.tableFooterView = [UIView new];
    _HideUncalledCell = HideUncalledCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (_dataArray) {
        return _sections ? _sections : 1;
    }
    
    NSAssert(_NumberOfSections, @"Number of Sections Block Must be Achieve");
    return _NumberOfSections(tableView);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSAssert(_NumberOfRowsInSection, @"Number of Rows in Section Must be Achieve");
    return _NumberOfRowsInSection(tableView, section);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    @autoreleasepool {
        
        NSAssert(_CellForRowAtIndexPath, @"Achieve _CellForAtIndexPathBlock!");
        UITableViewCell * cell = _CellForRowAtIndexPath(tableView, indexPath);
        if (_FullHorizontalSeparateLine) {
            
            if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
                [cell setSeparatorInset:UIEdgeInsetsZero];
            }
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                [cell setLayoutMargins:UIEdgeInsetsZero];
            }
        }
        if (_EnableSmoothnessTableView) {
            
            cell.layer.shouldRasterize = YES;
            cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return _HeightForRowAtIndexPath ? _HeightForRowAtIndexPath(tableView, indexPath) : 44.;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_SelectIndex) {
        _SelectIndex(tableView, indexPath);
    }
}

__unused DL_INLINE DLTableView * WeakSelf() {
    __block DLTableView * weakSelf = tableView;
    return weakSelf;
}

@end
