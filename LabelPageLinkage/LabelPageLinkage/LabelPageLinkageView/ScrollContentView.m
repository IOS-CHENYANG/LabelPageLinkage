//
//  ScrollContentView.m
//  wecastshopping
//
//  Created by 陈阳阳 on 2017/6/20.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import "ScrollContentView.h"

@interface ScrollContentView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

static NSString *reusedID = @"scrollcontentview";

@implementation ScrollContentView
{
    NSArray *_contentVcs;
}

- (void)dealloc {
    NSLog(@"-------- ScrollContentView ----------");
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)setContentVcs:(NSArray<UIViewController *> *)contentVcs {
    _contentVcs = contentVcs;
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.itemSize = self.bounds.size;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reusedID];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _contentVcs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusedID forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *vc = _contentVcs[indexPath.row];
    vc.view.frame = self.bounds;
    [cell.contentView addSubview:vc.view];
    return cell;
}

- (void)selectPageWithIndex:(NSInteger)index {
    self.collectionView.contentOffset = CGPointMake(index * self.collectionView.bounds.size.width, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX / scrollView.bounds.size.width;
    if ([self.delegate respondsToSelector:@selector(ScrollContentViewPageIndex:)]) {
        [self.delegate ScrollContentViewPageIndex:index];
    }
}

@end
