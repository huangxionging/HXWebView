# HXWebView

**_`HXWebView`_** 是一个适用于 `iOS` 所有版本的 web 和原生
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

##重点
