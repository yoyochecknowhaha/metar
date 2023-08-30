//
//  MTHomeData.h
//  metar
//
//  Created by 关山第一渣男 on 2023/8/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTHomeData : NSObject

/// 获得拍摄结果分页
+ (void)shootResultWithPageNo:(NSInteger)pageNo scrollView:(UIScrollView *)scrollView successBlock:(requestSuccessBlock)successBlock;

/// 批量删除拍摄结果
+ (void)deleteShootResultWithIDs:(NSString *)ids successBlock:(requestSuccessBlock)successBlock;

/// 获取标定图
+ (void)getPaperSuccessBlock:(requestSuccessBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
