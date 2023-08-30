//
//  MTHomeData.m
//  metar
//
//  Created by 关山第一渣男 on 2023/8/7.
//

#import "MTHomeData.h"

// model
#import "MTShootModel.h"

@implementation MTHomeData

/// 获得拍摄结果分页
+ (void)shootResultWithPageNo:(NSInteger)pageNo scrollView:(UIScrollView *)scrollView successBlock:(requestSuccessBlock)successBlock {
    FMCHttpHelper *helper = [[FMCHttpHelper alloc] init];
    NSString *url = [FMCURLHelper getURLWithPath:kShootResultPath];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageNo"] = @(pageNo);
    params[@"pageSize"] = @(10);
    [helper get:url params:params isShowHud:YES success:^(NSInteger state, NSString *msg, NSDictionary *data) {
        scrollView.mj_footer.hidden = NO;
        [scrollView.mj_header endRefreshing];
        [scrollView.mj_footer endRefreshing];
        NSMutableArray<MTShootModel *> *shootResultList = [MTShootModel mj_objectArrayWithKeyValuesArray:[data sui_arrayForKey:@"list"]];
        if (shootResultList.count) {
            MTShootModel *shoot = shootResultList[1];
            shoot.status = @"2";
            [scrollView.mj_footer resetNoMoreData];
            scrollView.mj_footer.state = MJRefreshStateIdle;
        } else {
            [scrollView.mj_footer endRefreshingWithNoMoreData];
            scrollView.mj_footer.state = MJRefreshStateNoMoreData;
        }
        successBlock(state, msg, shootResultList);
        NSLog(@"page = %zd, count = %zd", pageNo, shootResultList.count);
    } failure:^(NSInteger state, NSError *error, id cacheData) {
        scrollView.mj_footer.hidden = NO;
        [scrollView.mj_header endRefreshing];
        [scrollView.mj_footer endRefreshing];
    }];
}

/// 批量删除拍摄结果
+ (void)deleteShootResultWithIDs:(NSString *)ids successBlock:(requestSuccessBlock)successBlock {
    FMCHttpHelper *helper = [[FMCHttpHelper alloc] init];
    NSString *url = [FMCURLHelper getURLWithPath:kDeleteShootResultsPath];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ids"] = ids;
    [helper shanchu:url params:params isShowHud:YES success:^(NSInteger state, NSString *msg, id data) {
        successBlock(state, msg, data);
    } failure:^(NSInteger state, NSError *error, id cacheData) {
    }];
}

/// 获取标定图
+ (void)getPaperSuccessBlock:(requestSuccessBlock)successBlock {
    FMCHttpHelper *helper = [[FMCHttpHelper alloc] init];
    NSString *url = [FMCURLHelper getURLWithPath:kPaperPath];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"productLineType"] = @"1";
    params[@"productVersion"] = @"1.0.0";
    [helper get:url params:params isShowHud:YES success:^(NSInteger state, NSString *msg, id data) {
        successBlock(state, msg, data);
    } failure:^(NSInteger state, NSError *error, id cacheData) {
    }];
}

@end
