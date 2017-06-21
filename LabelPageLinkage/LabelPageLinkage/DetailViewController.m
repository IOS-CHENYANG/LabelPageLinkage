//
//  DetailViewController.m
//  LabelPageLinkage
//
//  Created by 陈阳阳 on 2017/6/21.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [self randomColor];
}
- (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (void)dealloc {
    NSLog(@"------detaileviewcontroller dealloc-----------");
}

@end
