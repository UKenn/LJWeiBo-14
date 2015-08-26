//
//  LJOAuthViewController.m
//  LJWeiBo
//
//  Created by qianfeng on 15-7-17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

/**
  App Key:2968142653
  App Secret：e9c8ffccec006288a0af08500ebcb2cb
 code=02604922b5ecf97ee1da33b280c93510
 
 https://api.weibo.com/oauth2/authorize?client_id=2968142653&redirect_uri=http://www.nhukenn.icoc.cc/index.jsp
 
 微博授权登陆页面地址： https://api.weibo.com/oauth2/authorize
 */

#import "LJOAuthViewController.h"
#import "AFNetworking.h"
#import "LJAccount.h"
#import "LJWeiboTool.h"
#import "MBProgressHUD+MJ.h"
#import "LJAccountTool.h"

@interface LJOAuthViewController () <UIWebViewDelegate>

@end

@implementation LJOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 2.加载授权页面(新浪提供的登录页面)
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2968142653&redirect_uri=http://www.nhukenn.icoc.cc/index.jsp"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}


#pragma mark - webView代理方法
/**
 *  webView开始发送请求的时候就会调用
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 显示提醒框
    [MBProgressHUD showMessage:@"正在帮你加载中..."];
}

/**
 *  webView请求完毕的时候就会调用
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}
/**
 *  webView请求失败的时候就会调用
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}

/**
 *  当webView发送一个请求之前都会先调用这个方法, 询问代理可不可以加载这个页面(请求)
 *
 *  @return YES : 可以加载页面,  NO : 不可以加载页面
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",request.URL);
    // 1.请求的URL路径:
    NSString *urlStr = request.URL.absoluteString;
    
    // 2.查找code=在urlStr中的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    
    // 3.如果urlStr中包含了code=
    //    if (range.location != NSNotFound)
    if (range.length) {
        // 4.截取code=后面的请求标记(经过用户授权成功的)
        NSInteger loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        
        // 5.发送POST请求给新浪,  通过code换取一个accessToken
        [self accessTokenWithCode:code];
        NSLog(@"code%@",code);
    }
    
    return YES;
}

/**
 *  通过code换取一个accessToken
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // AFNetworking\AFN
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"2968142653";
    params[@"client_secret"] = @"e9c8ffccec006288a0af08500ebcb2cb";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.nhukenn.icoc.cc/index.jsp";
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          // 4.先将字典转为模型
          LJAccount *account = [LJAccount accountWithDict:responseObject];
          NSLog(@"accessToken%@",responseObject);
          // 5.存储模型数据
          [LJAccountTool saveAccount:account];
          
          // 6.新特性\去首页
          [LJWeiboTool chooseRootController];
          
          // 7.隐藏提醒框
          [MBProgressHUD hideHUD];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          // 隐藏提醒框
          [MBProgressHUD hideHUD];
      }];
}

@end
