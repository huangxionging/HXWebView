//
//  ViewController.m
//  HXWebView
//
//  Created by huangxiong on 16/4/6.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import "ViewController.h"
#import "HXWebView.h"

@interface ViewController ()
@property (nonatomic, strong) HXWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"网页调用原生方法(实现 js 交互)";
    
    NSString *path = [[NSBundle mainBundle] pathForResource: @"indexJS" ofType: @"html"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString: path]];
    [self.webView loadRequest: request];
    
    [self.webView addScriptMessageHandlerBlock:^(id result) {
        NSLog(@"结果是: %@", result);
    } name: @"openCameraMore"];
    
    [self.webView addScriptMessageHandlerBlock:^(id result) {
        NSLog(@"结果是: %@", result);
    } name: @"openCameraMoreAndMore"];
}

- (HXWebView *)webView {
    if (_webView == nil) {
        _webView = [[HXWebView alloc] initWithFrame: self.view.bounds];
        [self.view addSubview: _webView];
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
