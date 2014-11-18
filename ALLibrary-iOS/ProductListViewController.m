//
//  ProductListViewController.m
//  ALLibrary-iOS
//
//  Created by chendong on 14-11-17.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "ProductListViewController.h"

@interface ProductListViewController () <UITableViewDataSource,
                                         UITableViewDelegate> {
  BOOL hasMore;
  NSInteger m_currentPage;
}
@property(strong, nonatomic) IBOutlet UITableView *m_tableView;
@property(strong, nonatomic) NSMutableArray *m_productList;
@end

@implementation ProductListViewController
@synthesize m_productList;
@synthesize m_tableView;

- (void)dealloc {
  self.m_tableView.delegate = nil;
  self.m_tableView.dataSource = nil;
}

- (void)loadView {
  [super loadView];
  super._tableView = self.m_tableView;
  [self createEGORefreshTableHeaderView];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.m_productList = [NSMutableArray array];
  m_currentPage = 1;
  hasMore = YES;
  // Do any additional setup after loading the view.
  [self requestProductListData];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark 重写父类方法
//子类需要重写
- (void)downRefresh {
  m_currentPage = 1;
  [self requestProductListData];
}
- (void)requestMore {
  if (hasMore) {
    m_currentPage++;
    [self requestProductListData];
  }
}

- (void)requestProductListData {

  if (m_currentPage == 1) {
    [self.m_productList removeAllObjects];
  }
  [self.m_productList
      addObjectsFromArray:[NSArray arrayWithObjects:@"张三", @"李四",
                                                    @"王五", @"赵六",
                                                    @"陈七", @"朱八", nil]];
  if ([m_productList count] < kMaxCount) {
    hasMore = YES;
  } else {
    hasMore = NO;
  }
  [self.m_tableView reloadData];
}

#pragma mark -
#pragma mark UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return [m_productList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = nil;
  static NSString *cellIdentifier = @"ProductListCellIdentifier";
  cell = (UITableViewCell *)
      [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                      forIndexPath:indexPath];
  if (indexPath.row < [m_productList count]) {
    cell.textLabel.text =
        [NSString stringWithFormat:@"Row:%d %@", indexPath.row,
                                   [m_productList objectAtIndex:indexPath.row]];
  }

  return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
