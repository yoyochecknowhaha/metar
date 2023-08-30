//
//  MTCollectionViewFlowLayout.m
//  metar
//
//  Created by 关山第一渣男 on 2023/8/7.
//

#import "MTCollectionViewFlowLayout.h"

@implementation MTCollectionViewFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat itemSpacing = 15;
        CGFloat cellWidth = (screenWidth - 3 * itemSpacing) / 2; // 2列，3个间距
        CGFloat cellHeight = cellWidth * 1.686;

        self.itemSize = CGSizeMake(cellWidth, cellHeight);
        self.minimumInteritemSpacing = itemSpacing; // 列间距
        self.minimumLineSpacing = itemSpacing;      // 行间距
        self.sectionInset = UIEdgeInsetsMake(itemSpacing, itemSpacing, itemSpacing, itemSpacing); // 上下左右边距
    }
    return self;
}

@end
