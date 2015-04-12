# DLTableView

[![Build Status](https://travis-ci.org/WildDylan/DLTableView.svg)](https://travis-ci.org/WildDylan/DLTableView)


play.... for entertainment

#####Demo for use

```
    // Demo for use
    DLTableView * tableView = [[DLTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    tableView.EnableSmoothnessTableView = YES;
    tableView.FullHorizontalSeparateLine = YES;
    tableView.HideUncalledCell = YES;
    tableView.TBGColor = [UIColor greenColor];
    
    [self.view addSubview:tableView];
    
    [tableView setNumberOfSections:^NSInteger(UITableView * tableView) {
        
        return 2;
    }];
    
    [tableView setNumberOfRowsInSection:^NSInteger(UITableView * tableView, NSInteger section) {
        
        return 5;
    }];
    
    [tableView setCellForRowAtIndexPath:^UITableViewCell *(UITableView * tableView, NSIndexPath * indexPath) {
        
        UITableViewCell * tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
        if (!tableViewCell) {
            tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Identifier"];
        }
        tableViewCell.textLabel.text = @"DLTableView";
        return tableViewCell;
    }];
    
    [tableView setSelectIndex:^(UITableView * tableView, NSIndexPath * indexPath) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSLog(@"Select IndexPath: %@", indexPath);
    }];
    
    [tableView setHeightForRowAtIndexPath:^CGFloat(UITableView * tableView, NSIndexPath * indexPath) {
        
        return 40.;
    }];

```

```
//! @abstract Table View, change some properties befor layoutviews...
@property (nonatomic, strong) UITableView * tableView;

/**
 *  @param frame View Frame, table is subView for View. equal frame
 *  @param style table view style.
 */
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;

//! @abstract Bind Table View delegate and DataSources, give up blocks
- (void)BindDelegateTo: (id)object;

// - For lazybones... - //

//! @abstract Data Array, Default Section is 1, Row in Section is _dataArray.count
@property (nonatomic, strong) NSMutableArray * dataArray;

//! @abstract Cell Sections
@property (nonatomic, assign) NSInteger sections;

// - Properties - //

// For Table View backgroundColor
@property (nonatomic, strong) UIColor * TBGColor;

//! @abstract Table View vavkground View
@property (nonatomic, strong) UIView * BGView;

// - Boolean properties - //

//! @abstract 分割线是否顶格 /// SeparateLine inset zero
@property (nonatomic, assign) BOOL FullHorizontalSeparateLine;

//! @abstract 列表优化 平滑滑动 /// Smooth Scroll opt
@property (nonatomic, assign) BOOL EnableSmoothnessTableView;

//! @abstract 样式为Plain时, 隐藏多余的空白cell /// For Plain Style.
@property (nonatomic, assign) BOOL HideUncalledCell;

// - Nib Properties, Register class and Set identifier - //

//! @abstract For Nib
@property (nonatomic, assign) Class cellClass;

//! @abstract Nib Identifier
@property (nonatomic, strong) NSString * identifier;

// - Delegate And DataSoure Blocks - //

//! @abstract Number of sections, if you set `dataArray`, Default is 1, please set sections.
@property (nonatomic, copy) NSInteger (^NumberOfSections)(UITableView * tableView);

//! @abstract Number of rows in section, Must implement
@property (nonatomic, copy) NSInteger (^NumberOfRowsInSection)(UITableView * tableView, NSInteger section);

//! @abstract Height for row, Default is 44.
@property (nonatomic, copy) CGFloat (^HeightForRowAtIndexPath)(UITableView * tableView, NSIndexPath * indexPath);

//! @abstract Cell For Row, Must implement
@property (nonatomic, copy) UITableViewCell* (^CellForRowAtIndexPath)(UITableView * tableView, NSIndexPath * indexPath);

//! @abstract Selected Index, implement it if you want monite this action
@property (nonatomic, copy) void (^SelectIndex)(UITableView * tableView, NSIndexPath * indexPath);

```
