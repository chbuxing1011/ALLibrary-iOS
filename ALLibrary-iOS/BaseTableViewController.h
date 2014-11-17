//
//  BaseTableViewController.h
//  ALLibrary-iOS
//
//  Created by chendong on 14-11-17.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//
/*
 *
 1.所需实现类继承于BaseTableViewController
 2.super._tableView  指向子类中已经实例化的TableView对象（例：super._tableView = self.m_tableView;）
 3.调用父类[self createEGORefreshTableHeaderView];
 4.重写父类方法
 - (void)downRefresh；（下拉时触发）
 - (void)requestMore；（上拉到底时触发）

 */

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController
{
    UITableView *_tableView;
}
- (void)createEGORefreshTableHeaderView;

@property(nonatomic,strong) UITableView *_tableView;
@end
