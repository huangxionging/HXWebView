# HXWebView

**_`HXWebView`_** 是一个适用于 `iOS` 所有版本的 web js 和原生
页面交互的 webView 控件, 以 UIWebView 和 WKWebView 为基础
, 使用 block 回调来传输 web 和原生页面的数据, 使用简单方便.
***

**_`HXWebView`_** is applicable to all versions of 
`iOS`and native web page interaction webView 
controls to UIWebView and WKWebView based on the 
use of block callback to transfer data web and 
native pages, easy to use. (使用谷歌翻译:smile:)
*** 

## 如何开始
* [下载 **_`HXWebView`_**](https://github.com/huangxionging/HXWebView/archive/master.zip)
然后解压, 运行 demo.
* 查看源代码了解工作原理. 
* 在项目中嵌入 HXWebView

## HXWebView 结构
| HXWebView method       |      brief             | parameter | 
|:----------------------:|:----------------------:| :--------:|
|- (void)loadRequest:(NSURLRequest *)request; | 请求网络数据 | NSURLRequest 网络请求|
|- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;| 加载 html 数据| html 数据和访问目录|
|- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL; |加载二进制数据| 二进制 data, 多媒体文件类型, 文本编码以及访问目录|
|- (void)loadFileURL:(NSURL *)URL allowingReadAccessToURL:(NSURL *)readAccessURL;| 加载文件| 文件 URL和目录|
|- (void) addScriptMessageHandlerBlock: (void(^)(id result)) block name:(NSString *) name;| 添加处理消息的回调| block 和 对应的名称 |

##提示
```
1. 在 js 脚本中使用如下方法传递参数:
window.webkit.messageHandlers.xxxx.postMessage(yyyy) (适用于 iOS 8以后版本, 效率高一些),
 或者 window.location.href= "aaaa://xxxx/zzzz"(适用于所有版本), 其中 xxxx 即为要监测的 name
  并在 "aaaa://xxxx/zzzz" 这样的 URL 格式中作为 host, 参考 demo.
  
2. addScriptMessageHandlerBlock 中的 name 用作对应的标识符
若 js 使用 window.location.href = "aaaa://xxxx/zzzz, name 对应为 url 的 host xxxx, 每个 host 对应一个 block.
若 js 使用 window.webkit.messageHandlers.xxxx.postMessage(yyyy), name 则为名字 xxxx. 所有 block 和 name 
一一对应, 使用 NSMutableDictionary 存储, 每次根据 name 查询 block, 并调用不同的 block.
```

##使用
```Objective-C
NSString *path = [[NSBundle mainBundle] pathForResource: @"indexJS" ofType: @"html"];
    
NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString: path]];
[self.webView loadRequest: request];
    
[self.webView addScriptMessageHandlerBlock:^(id result) {
    NSLog(@"结果是: %@", result);
} name: @"openCameraMore"];

[self.webView addScriptMessageHandlerBlock:^(id result) {
    NSLog(@"结果是: %@", result);
} name: @"openCameraMoreAndMore"];
 ```