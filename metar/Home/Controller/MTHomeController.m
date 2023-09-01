//
//  MTHomeController.m
//  metar
//
//  Created by 关山第一渣男 on 2023/7/30.
//

#import "MTHomeController.h"

// controller
#import "MTSettingController.h"
#import "MTScanningController.h"

// model
#import "MTCollectionViewFlowLayout.h"
#import "MTShootModel.h"

// view
#import "MTShootResultCell.h"

// data
#import "MTHomeData.h"
#import "metar-Swift.h"

@interface MTHomeController () <UICollectionViewDataSource, UICollectionViewDelegate, MTHideNavigationBar, MTShootResultCellDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *btn0;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, strong) NSMutableArray<MTShootModel *> *shootResultList;
@property (nonatomic, assign, getter=isEditingState) BOOL editingState;

@end

@implementation MTHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btn0 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [self.btn1 setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    self.titleLabel.text = @"拍摄结果";
    [self refreshShootResult];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setupCollectionView];
}

- (IBAction)touchBtn1:(UIButton *)btn1 {
    if (self.isEditingState) {
        self.editingState = NO;
        self.titleLabel.text = @"拍摄结果";
        [self.btn0 setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
        [self.btn1 setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
        self.btn0.enabled = YES;
        for (MTShootModel *shoot in self.shootResultList) {
            shoot.editing = NO;
        }
    } else {
        self.editingState = YES;
        self.titleLabel.text = @"选择拍摄数据";
        [self.btn0 setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [self.btn1 setImage:[UIImage imageNamed:@"reset"] forState:UIControlStateNormal];
        self.btn0.enabled = NO;
        for (MTShootModel *shoot in self.shootResultList) {
            shoot.editing = YES;
            shoot.canSelected = ([shoot.status integerValue] == 3);
        }
    }
    [self.collectionView reloadData];
}

- (IBAction)touchBtn0:(UIButton *)btn0 {
    if (self.isEditingState) {
        // 删除
        NSString *ids = @"";
        NSMutableArray<MTShootModel *> *deleteList = [NSMutableArray array];
        for (MTShootModel *shoot in self.shootResultList) {
            if (!shoot.isSelected) continue;
            ids = [ids stringByAppendingFormat:@",%@", shoot.ID];
            [deleteList addObject:shoot];
        }
        if (!ids.length) return;
        ids = [ids substringFromIndex:1];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除数据" message:@"您确认想删除这些拍摄结果已及他们的本地数据吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action0];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self deleteShootResultWithIDs:ids deleteList:deleteList];
        }];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        // 设置
        MTSettingController *settingController = [[MTSettingController alloc] init];
        MTNavigationController *navController = [[MTNavigationController alloc] initWithRootViewController:settingController];
        [self.navigationController presentViewController:navController animated:YES completion:nil];
    }
}

- (void)deleteShootResultWithIDs:(NSString *)IDs deleteList:(NSMutableArray<MTShootModel *> *)deleteList {
    [MTHomeData deleteShootResultWithIDs:IDs successBlock:^(NSInteger state, NSString *msg, id data) {
        NSMutableArray<NSIndexPath *> *indexPaths = [NSMutableArray array];
        for (MTShootModel *shoot in deleteList) {
            [indexPaths addObject:[NSIndexPath indexPathForItem:[self.shootResultList indexOfObject:shoot] inSection:0]];
        }
        [self.shootResultList removeObjectsInArray:deleteList];
        [self.collectionView deleteItemsAtIndexPaths:indexPaths];
    }];
}

- (void)refreshShootResult {
    self.editingState = YES;
    [self touchBtn1:self.btn1];
    self.pageNo = 1;
    [MTHomeData shootResultWithPageNo:self.pageNo scrollView:self.collectionView successBlock:^(NSInteger state, NSString *msg, NSMutableArray<MTShootModel *> *shootResultList) {
        self.pageNo++;
        self.shootResultList = shootResultList;
        [self.collectionView reloadData];
        self.tipLabel.hidden = shootResultList.count;
        self.collectionView.hidden = !shootResultList.count;
    }];
}

- (void)loadMoreShootResult {
    self.editingState = YES;
    [self touchBtn1:self.btn1];
    [MTHomeData shootResultWithPageNo:self.pageNo scrollView:self.collectionView successBlock:^(NSInteger state, NSString *msg, NSMutableArray<MTShootModel *> *shootResultList) {
        if (shootResultList.count) {
            self.pageNo++;
            [self.shootResultList addObjectsFromArray:shootResultList];
            [self.collectionView reloadData];
        }
    }];
}

- (void)setupCollectionView {
    if (self.collectionView) return;
    MTCollectionViewFlowLayout *flowLayout = [[MTCollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bgView.bounds collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
//    self.collectionView.backgroundColor = [UIColor brownColor];
    [self.bgView addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MTShootResultCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MTShootResultCell class])];
    
    uWeakSelf
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshShootResult];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreShootResult];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.shootResultList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MTShootResultCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MTShootResultCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    cell.shoot = self.shootResultList[indexPath.item];
    return cell;
}

#pragma mark - MTShootResultCellDelegate
- (void)shootResultCellSelectStateDidChanged:(MTShootResultCell *)shootResultCell {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:shootResultCell];
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    NSInteger count = 0;
    for (MTShootModel *shoot in self.shootResultList) {
        if (!shoot.isSelected) continue;
        count++;
    }
    self.btn0.enabled = count;
}

- (IBAction)touchAddBtn:(UIButton *)addBtn {
//    ViewController *scanningController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
//    ViewController *viewController = storyboard.instantiateViewController(withIdentifier: identifier)
//    ViewController *scanningController = [[ViewController alloc] init];
//    MTScanningController *scanningController = [[MTScanningController alloc] init];
    
    ViewController *scanningController = [[ViewController alloc] init];
    [self.navigationController pushViewController:scanningController animated:YES];
}


@end
