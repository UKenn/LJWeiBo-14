//
//  LJHomeViewController.m
//  LJWeiBo
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//1212

#import "LJHomeViewController.h"
#import "UIBarButtonItem+LJ.h"
#import "UIImage+LJ.h"
#import "LJTitleButton.h"
#import "AFNetworking.h"
#import "LJAccountTool.h"
#import "LJAccount.h"
#import "UIImageView+WebCache.h"
#import "LJStatus.h"
#import "LJUser.h"
#import "MJExtension.h"
#import "LJStatusFrame.h"
#import "LJStatusCell.h"

@interface LJHomeViewController ()
@property (nonatomic, strong) NSArray *statusFrame;

@end

@implementation LJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1 设置导航栏
    [self setupNaviBar];
    //2 加载微博数据
    [self setupStatusData];
    
    [self.tableView registerClass:[LJStatusCell class] forCellReuseIdentifier:@"Cell"];
}

//设置导航栏
- (void)setupNaviBar
{
    //设置左边按钮
    //新建一个分类，用来专门创建一个barbuttonitem，（通过繁琐的代码优化而来）
    self.navigationItem.leftBarButtonItem =[UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    
    //设置右边按钮
    self.navigationItem.rightBarButtonItem =[UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    LJTitleButton *titleButton = [LJTitleButton titleButton];
    //图标
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    //文字
    [titleButton setTitle:@"看你敢不敢点" forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(titleButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
    titleButton.frame = CGRectMake(0, 0, 150, 40);
    self.navigationItem.titleView = titleButton;
}

/**
 *  加载微博数据
 */
- (void)setupStatusData
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [LJAccountTool account].access_token;
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         //字典转数组
         NSArray * statusArray = [LJStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
         NSMutableArray *statusFrameArray = [NSMutableArray array];
         for (LJStatus *status in statusArray) {
             //创建一个frame模型
             LJStatusFrame *statusFrame = [[LJStatusFrame alloc] init];
             //给frame模型的数据模型赋值
             statusFrame.status =status;
             //将frame模型加入frame模型数组
             [statusFrameArray addObject:statusFrame];
         }
         self.statusFrame = statusFrameArray;
         // 刷新表格
         [self.tableView reloadData];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];
}

//标题按钮
- (void)titleButtonAciton:(UIButton *)button
{
    if(button.tag == -1){
        [button setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        button.tag = 0;
    }else{
        [button setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        button.tag = -1;
    }
}

//找朋友
- (void)findFriend
{
    NSLog(@"findFriend");
}

//推
- (void)pop
{
    NSLog(@"pop");
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 1.创建cell
    LJStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // 2.设置cell的数据
    cell.statusFrame = self.statusFrame[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor purpleColor];
//    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJStatusFrame *statusFrame = self.statusFrame[indexPath.row];
    return statusFrame.cellHeight;
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
