//
//  HomeViewController.m
//  LabelPageLinkage
//
//  Created by 陈阳阳 on 2017/6/21.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import "HomeViewController.h"
#import "LabelPageLinkageView.h"
#import "WSNet.h"
#import "DetailViewController.h"

@interface HomeViewController ()

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,strong) LabelPageLinkageView *linkageView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.linkageView = [[LabelPageLinkageView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) segmentViewHeight:30];
    [self.view addSubview:self.linkageView];
    
    [self categoryList];
    
}

- (void)categoryList {
    [WSNet httpGet:@"http://121.40.133.100/wecast_shop/videoOperations.do" params:@{@"lang":@"zh_cn"} success:^(id responseData) {
        NSLog(@"responseData = %@",responseData);
        self.dataArray = responseData[@"operations"];
        NSMutableArray *tempTitlesArray = [NSMutableArray array];
        NSMutableArray *tempContentVcsArray = [NSMutableArray array];
        for (NSDictionary *item in self.dataArray) {
            NSString *category = item[@"cnName"];
            [tempTitlesArray addObject:category];
            DetailViewController *detail = [[DetailViewController alloc]init];
            [tempContentVcsArray addObject:detail];
        }
        self.linkageView.titleArray = tempTitlesArray.copy;
        self.linkageView.contentVcs = tempContentVcsArray.copy;

    } failure:^(NSInteger code, NSError *error) {
        
    }];
}

- (void)dealloc {
    NSLog(@"----------homeviewcontroller dealloc------");
}

@end
