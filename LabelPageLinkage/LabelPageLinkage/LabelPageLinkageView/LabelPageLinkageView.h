//
//  LabelPageLinkageView.h
//  wecastshopping
//
//  Created by 陈阳阳 on 2017/6/21.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelPageLinkageView : UIView

@property (nonatomic,strong) NSArray <NSString *> *titleArray;

@property (nonatomic,strong) NSArray <UIViewController *> *contentVcs;

- (instancetype)initWithFrame:(CGRect)frame segmentViewHeight:(CGFloat)height;

@end
