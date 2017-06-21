//
//  ScrollSegmentView.m
//  wecastshopping
//
//  Created by 陈阳阳 on 2017/6/20.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import "ScrollSegmentView.h"

#define TitleMargin  36 // 标题间距
#define TitleNorFont [UIFont systemFontOfSize:14] // 标题字体
#define TitleSelFont [UIFont fontWithName:@"Helvetica-Bold" size:18] // 选中标题字体
#define TitleNorColor [UIColor whiteColor] // 标题颜色
#define TitleSelColor [UIColor redColor]   // 选中标题颜色

@interface ScrollSegmentView ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation ScrollSegmentView

- (void)dealloc {
    NSLog(@"-------- ScrollSegmentView ----------");
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray {
    __block CGFloat totalWidth = TitleMargin;
    [titleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:obj forState:UIControlStateNormal];
        button.titleLabel.font = TitleNorFont;
        [button setTitleColor:TitleNorColor forState:UIControlStateNormal];
        if (idx == 0) {
            self.currentIndex = 0;
            button.titleLabel.font = TitleSelFont;
            [button setTitleColor:TitleSelColor forState:UIControlStateNormal];
        }
        [self.scrollView addSubview:button];
        CGFloat buttonX = totalWidth;
        CGFloat buttonY = 0;
        CGFloat buttonW = [self titleWidth:obj];
        CGFloat buttonH = self.bounds.size.height;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.tag = 20170620 + idx;
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        totalWidth = totalWidth + buttonW + TitleMargin;
    }];
    self.scrollView.contentSize = CGSizeMake(totalWidth, 0);
}

- (void)selectItemWithIndex:(NSInteger)index {
    UIButton *button = (UIButton *)[self.scrollView viewWithTag:index + 20170620];
    [self titleClick:button];
}

- (void)titleClick:(UIButton *)sender {
    NSInteger index = sender.tag - 20170620;
    if (self.currentIndex == index) { return; }
    [UIView animateWithDuration:0.3 animations:^{
        UIButton *button = (UIButton *)[self.scrollView viewWithTag:self.currentIndex + 20170620];
        [button setTitleColor:TitleNorColor forState:UIControlStateNormal];
        button.titleLabel.font = TitleNorFont;
        [sender setTitleColor:TitleSelColor forState:UIControlStateNormal];
        sender.titleLabel.font = TitleSelFont;
        self.currentIndex = index;
        [self setSelectedTitleCenter:sender];
    }];
    if ([self.delegate respondsToSelector:@selector(ScrollSegmentViewDidSelectedTitle:)]) {
        [self.delegate ScrollSegmentViewDidSelectedTitle:index];
    }
}

- (void)setSelectedTitleCenter:(UIButton *)sender {
    CGFloat offsetX = sender.center.x - self.scrollView.bounds.size.width * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    CGFloat maxOffsetX = self.scrollView.contentSize.width - self.scrollView.bounds.size.width;
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    self.scrollView.contentOffset = CGPointMake(offsetX, 0);
}

- (CGFloat)titleWidth:(NSString *)title {
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:TitleSelFont} context:nil].size;
    return titleSize.width;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollEnabled = YES;
    }
    return _scrollView;
}

@end
