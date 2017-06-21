//
//  ScrollContentView.h
//  wecastshopping
//
//  Created by 陈阳阳 on 2017/6/20.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollContentViewDelegate <NSObject>

- (void)ScrollContentViewPageIndex:(NSInteger)index;

@end

@interface ScrollContentView : UIView

@property (nonatomic,weak) id <ScrollContentViewDelegate> delegate;

@property (nonatomic,strong) NSArray <UIViewController *> *contentVcs;

- (void)selectPageWithIndex:(NSInteger)index;

@end
