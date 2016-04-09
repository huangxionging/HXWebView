//
//  HXWebView.h
//  HXWebView
//
//  Created by huangxiong on 16/4/6.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@class UIWebView, WKWebView;

@interface HXWebView : UIView {
    @private
    UIWebView *_webView;
    WKWebView *_wkWebView;
}


/**
 *  @author huangxiong, 2016/04/07 09:47:08
 *
 *  @brief 请求网络数据
 *
 *  @param request 包含网络地址的请求
 *
 *  @since 1.0
 */
- (void)loadRequest:(NSURLRequest *)request;

/**
 *  @author huangxiong, 2016/04/07 20:01:51
 *
 *  @brief 加载 html 文本
 *
 *  @param string  字符串
 *  @param baseURL 目录
 *
 *  @since 1.0
 */
- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;

/**
 *  @author huangxiong, 2016/04/07 20:01:13
 *
 *  @brief 加载二进制文件
 *
 *  @param data             数据
 *  @param MIMEType         数据类型
 *  @param textEncodingName 编码格式
 *  @param baseURL          所在目录
 *
 *  @since 1.0
 */
- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL;
/**
 *  @author huangxiong, 2016/04/07 20:00:06
 *
 *  @brief 加载文件
 *
 *  @param URL           文件地址
 *  @param readAccessURL 访问地址, 基本上是资源文件所在目录
 *
 *  @since 1.0
 */
- (void)loadFileURL:(NSURL *)URL allowingReadAccessToURL:(NSURL *)readAccessURL;

/**
 *  @author huangxiong, 2016/04/08 17:01:39
 *
 *  @brief 添加脚本消息处理的回调
 *
 *  @param block 消息处理的回调
 *  @param name  名称
 *
 *  @since 1.0
 *
 *  @discussion javascript 端可以选择 window.webkit.messageHandlers.xxxx.postMessage(yyyy)(适用于 iOS 8以后版本, 效率高一些), 或者 window.location.href = "aaaa://xxxx/zzzz"(适用于所有版本), 其中 xxxx 即为要监测的 name 并在 "aaaa://xxxx/zzzz" 这样的 URL 格式中作为 host, 参考 demo
 */
- (void) addScriptMessageHandlerBlock: (void(^)(id result)) block name:(NSString *) name;

//- (void) setWebViewFont: (CGFloat) fontSize;


@end
