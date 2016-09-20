//
//  ViewController.m
//  Demo
//
//  Created by zhangchao on 16/9/20.
//  Copyright © 2016年 zhangchao. All rights reserved.
//

#import "ViewController.h"
#import "ZCControl.h"

@interface ViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,weak) id<ZCNavigationDelegate> delegate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"首页";
    self.delegate = [ZCControl shared];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"右" style:UIBarButtonItemStylePlain target:self action:nil];
}


#pragma mark
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentity = @"CellID";
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if(!tableViewCell) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    tableViewCell.textLabel.text = @"导航上拉渐变";
    return tableViewCell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset_Y = scrollView.contentOffset.y;
    if([self.delegate respondsToSelector:@selector(setHeightOfGradient:AndScrollViewContentOffsetY:AndControl:)])
    {
        [self.delegate setHeightOfGradient:-64 AndScrollViewContentOffsetY:offset_Y AndControl:self];
    }
}


- (UITableView *)tableView
{
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}


@end
