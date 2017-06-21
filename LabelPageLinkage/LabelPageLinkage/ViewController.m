//
//  ViewController.m
//  LabelPageLinkage
//
//  Created by 陈阳阳 on 2017/6/19.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import "ViewController.h"
#import "WSNet.h"
#import "LabelPageLinkageView.h"
#import "HomeViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (IBAction)buttonClick:(id)sender {
    HomeViewController *home = [[HomeViewController alloc]init];
    [self.navigationController pushViewController:home animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}




@end
