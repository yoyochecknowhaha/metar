//
//  MTCollectionViewCell.h
//  metar
//
//  Created by 关山第一渣男 on 2023/8/7.
//

#import <UIKit/UIKit.h>

@class MTShootModel, MTShootResultCell;

@protocol MTShootResultCellDelegate <NSObject>

@optional
- (void)shootResultCellSelectStateDidChanged:(MTShootResultCell *_Nonnull)shootResultCell;

@end

NS_ASSUME_NONNULL_BEGIN

@interface MTShootResultCell : UICollectionViewCell

@property (nonatomic, strong) MTShootModel *shoot;
@property (nonatomic, weak) id<MTShootResultCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
