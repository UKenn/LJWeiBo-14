//
//  LJDiscoverViewController.m
//  LJWeiBo
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LJDiscoverViewController.h"
#import "UIImage+LJ.h"
#import "LJSearchBar.h"

@interface LJDiscoverViewController ()

@end

@implementation LJDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个搜索栏(command + k 模拟器呼出退下手机键盘)
    LJSearchBar *searchBar = [LJSearchBar searchBar];
    searchBar.frame = CGRectMake(0, 0, 345, 30);
    self.navigationItem.titleView = searchBar;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.navigationItem.titleView resignFirstResponder];
}
@end
