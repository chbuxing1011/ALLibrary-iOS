//
//  BaseTableViewController.m
//  ALLibrary-iOS
//
//  Created by chendong on 14-11-17.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "BaseTableViewController.h"

#import "EGORefreshTableHeaderView.h"

@interface BaseTableViewController ()<EGORefreshTableHeaderDelegate,UIScrollViewDelegate>
{
    EGORefreshTableHeaderView *m_refreshView;
    BOOL m_isRefresh;                               //是否刷新
    
    
}
@property(nonatomic,strong) EGORefreshTableHeaderView *m_refreshView;
@property(nonatomic,assign) BOOL m_isRefresh;

@end

@implementation BaseTableViewController
@synthesize m_refreshView;
@synthesize m_isRefresh;
@synthesize _tableView;


- (void)createEGORefreshTableHeaderView
{
    //初始化
    self.m_refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self._tableView.frame.size.height, self._tableView.frame.size.width, self._tableView.frame.size.height)];
    //设置关联
    m_refreshView.delegate = self;
    //添加到tableView中
    [self._tableView addSubview:m_refreshView];
    
}
#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
//触发刷新
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    //刷新过程中触发的方法，并设定风火轮旋转时间（加载过程）
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1];
}


- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    return m_isRefresh;
}

//所有加载完成触发的函数
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    
    return [NSDate date];
}



#pragma mark -
#pragma mark UIScrollViewDelegate Methods
//拖动tableView时触发，展示下拉动态视图。
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [m_refreshView egoRefreshScrollViewDidScroll:scrollView];
}

//拖拽释放时触发
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //不可编辑状态才可以请求数据，否则不能刷新
    if(!self._tableView.isEditing)
    {
        //判断上拉还是下拉，如果是上拉则请求更多
        if (scrollView.contentOffset.y >0 &&scrollView.frame.size.height - (scrollView.contentSize.height - scrollView.contentOffset.y) > 0)
        {
            //判断hasMore是否还有数据，有的话请求，没有不做操作
            [self requestMore];
        }
        //改变视图状态
        [m_refreshView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}
//松手以后，刷新时间到了以后触发
- (void)doneLoadingTableViewData
{
    //刷新完成，退出正在刷新状态
    m_isRefresh = NO;
    //改变刷新顶视图的状态为完成状态，关闭风火轮，关闭下拉视图，否则就一直是风火轮在旋转
    [m_refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self._tableView];
}
//松手即触发，在这个方法中获取新数据
- (void)reloadTableViewDataSource
{
    //正在刷新，表明正在刷新，不能再次刷新
    m_isRefresh = YES;
    [self downRefresh];
}

//子类需要重写,下拉刷新
- (void)downRefresh
{
    
}
//请求更多
- (void)requestMore
{
    
}

@end
