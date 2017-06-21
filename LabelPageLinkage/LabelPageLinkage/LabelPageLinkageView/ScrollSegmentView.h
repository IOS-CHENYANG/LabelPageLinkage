//
//  ScrollSegmentView.h
//  wecastshopping
//
//  Created by 陈阳阳 on 2017/6/20.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollSegmentViewDelegate <NSObject>

- (void)ScrollSegmentViewDidSelectedTitle:(NSInteger)index;

@end

@interface ScrollSegmentView : UIView

@property (nonatomic,weak) id <ScrollSegmentViewDelegate> delegate;

@property (nonatomic,strong) NSArray <NSString *> *titleArray;

- (void)selectItemWithIndex:(NSInteger)index;

@end
