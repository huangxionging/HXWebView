//
//  HXWebView.m
//  HXWebView
//
//  Created by huangxiong on 16/4/6.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import "HXWebView.h"

// MAX_IOS_VERSION 大于等于 8.0, 不可小于 8.0
#define MAX_IOS_VERSION 8.0

@interface HXWebView () <UIWebViewDelegate, WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate>

/**
 *  @author huangxiong, 2016/04/09 11:43:18
 *
 *  @brief 系统版本
 *
 *  @since 1.0
 */
@property (nonatomic, assign)  CGFloat systemVersion;

/**
 *  @author huangxiong, 2016/04/09 11:42:46
 *
 *  @brief js 消息处理回调字典
 *
 *  @since 1.0
 */
@property (nonatomic, strong) NSMutableDictionary<NSString *, void(^)(id)> *blockDictionary;

@end

@implementation HXWebView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
        if (_systemVersion < MAX_IOS_VERSION) {
            _webView = [[UIWebView alloc] initWithFrame: self.bounds];
            _webView.backgroundColor = [UIColor clearColor];
            _webView.delegate = self;
            [self addSubview: _webView];
        } else {
            WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
            config.userContentController = [[WKUserContentController alloc] init];
            _wkWebView = [[WKWebView alloc] initWithFrame: self.bounds configuration: config];
            _wkWebView.navigationDelegate = self;
            [self addSubview: _wkWebView];
        }
        
    }
    return self;
}

#pragma mark- blockDictionary
- (NSMutableDictionary<NSString *,void (^)(id)> *)blockDictionary {
    if (_blockDictionary == nil) {
        _blockDictionary = [NSMutableDictionary dictionaryWithCapacity: 10];
    }
    return _blockDictionary;
}

#pragma mark- UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@", request.URL.absoluteString);
    NSString *host = request.URL.host;
    
    if (host) {
        void (^block)(id) = self.blockDictionary[host];
        if (block) {
            block(request.URL.absoluteString);
        }
    } else {
        NSLog(@"host 为空");
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

#pragma mark- WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    void (^block)(id) = self.blockDictionary[message.name];
    
    if (block) {
        block(message.body);
    }
}

#pragma mark- WKNavigationDelegate
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%@", webView.URL.absoluteString);
    NSString *host = webView.URL.host;
    
    if (host) {
        void (^block)(id) = self.blockDictionary[host];
        if (block) {
            block(webView.URL.absoluteString);
        }
    } else {
        NSLog(@"host 为空");
    }
    
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    completionHandler(NSURLSessionAuthChallengeUseCredential, nil);
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
}

#pragma mark- WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    completionHandler(YES);
}

#pragma mark- 加载网络请求
- (void)loadRequest:(NSURLRequest *)request {
    if (_systemVersion < MAX_IOS_VERSION) {
        [_webView loadRequest: request];
    } else {
        
        NSString *urlString = request.URL.absoluteString;
        NSLog(@"%@", urlString);
        // 如果是本地html文件 表示
        if ([urlString hasPrefix: @"/"] && [urlString hasSuffix: @".html"]) {
            
            NSURL *url = [NSURL fileURLWithPath: urlString];

            NSData *data = [NSData dataWithContentsOfURL: url];
            [_wkWebView loadData: data MIMEType: @"text/html" characterEncodingName: @"utf-8" baseURL: url];
        } else {
            [_wkWebView loadRequest: request];
        }
    }
}

#pragma mark- 加载数据
- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL {
    if (self.systemVersion < MAX_IOS_VERSION) {
        [_webView loadData: data MIMEType: MIMEType textEncodingName: textEncodingName baseURL: baseURL];
    } else {
        [_wkWebView loadData: data MIMEType: MIMEType characterEncodingName: textEncodingName baseURL: baseURL];
    }
}

#pragma mark- 加载 html 文本
- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL {
    if (self.systemVersion < MAX_IOS_VERSION) {
        [_webView loadHTMLString: string baseURL: baseURL];
    } else {
        [_wkWebView loadHTMLString: string baseURL: baseURL];
    }
}

#pragma mark- 加载文件
- (void)loadFileURL:(NSURL *)URL allowingReadAccessToURL:(NSURL *)readAccessURL {
    
    NSString *text = [NSString stringWithContentsOfURL: URL encoding: NSUTF8StringEncoding error: nil];

    if (self.systemVersion >= 9.0) {
        [_wkWebView loadFileURL: URL allowingReadAccessToURL: readAccessURL];
    } else if (self.systemVersion >= 8.0) {
        [_wkWebView loadHTMLString: text baseURL:readAccessURL];
    } else {
        [_webView loadHTMLString: text baseURL: readAccessURL];
    }
}

#pragma mark- 添加脚本消息回调
- (void)addScriptMessageHandlerBlock:(void (^)(id))block name:(NSString *)name {
    
    if (block && name) {
        void (^temp)(id) = self.blockDictionary[name];
        if (temp != nil) {
            NSLog(@"name : %@, 已被注册, 请换个名字", name);
            return;
        }
        [self.blockDictionary setObject: block forKey: name];
        
        // 根据系统版本
        if (self.systemVersion >= MAX_IOS_VERSION) {
            [_wkWebView.configuration.userContentController addScriptMessageHandler: self name: name];
        }
    }
    
}

//- (void)setWebViewFont:(CGFloat)fontSize {
//    [_webView stringByEvaluatingJavaScriptFromString: @""];
//}

@end
