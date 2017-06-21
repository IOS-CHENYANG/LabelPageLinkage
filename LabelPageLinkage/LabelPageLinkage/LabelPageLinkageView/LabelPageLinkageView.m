//
//  LabelPageLinkageView.m
//  wecastshopping
//
//  Created by 陈阳阳 on 2017/6/21.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import "LabelPageLinkageView.h"
#import "ScrollSegmentView.h"
#import "ScrollContentView.h"

@interface LabelPageLinkageView () <ScrollSegmentViewDelegate,ScrollContentViewDelegate>

@property (nonatomic,strong) ScrollSegmentView *segmentView;
@property (nonatomic,strong) ScrollContentView *contentView;

@end

@implementation LabelPageLinkageView

- (void)dealloc {
    NSLog(@"--------- LabelPageLinkageView ---------");
}

- (instancetype)initWithFrame:(CGRect)frame segmentViewHeight:(CGFloat)height {
    self = [super initWithFrame:frame];
    if (self) {
        self.segmentView = [[ScrollSegmentView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, height)];
        self.segmentView.delegate = self;
        [self addSubview:self.segmentView];
        self.contentView = [[ScrollContentView alloc]initWithFrame:CGRectMake(0, height, self.bounds.size.width, self.bounds.size.height - height)];
        self.contentView.delegate = self;
        [self addSubview:self.contentView];

    }
    return self;
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray {
    self.segmentView.titleArray = titleArray;
}

- (void)setContentVcs:(NSArray<UIViewController *> *)contentVcs {
    self.contentView.contentVcs = contentVcs;
}

- (void)ScrollSegmentViewDidSelectedTitle:(NSInteger)index {
    [self.contentView selectPageWithIndex:index];
}

- (void)ScrollContentViewPageIndex:(NSInteger)index {
    [self.segmentView selectItemWithIndex:index];
}

@end
