//
//  SCWebViewController.m
//  Runner
//
//  Created by mjl on 2023/1/13.
//

#import "SCWebViewController.h"
#import "SCCustomNavigationBar.h"
#import "SCFlutterKey.h"
#import <LMWebViewJavascriptBridge/WKWebViewJavascriptBridge.h>
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>
#import <KVOController/KVOController.h>

#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]

@interface SCWebViewController ()<WKNavigationDelegate, WKUIDelegate, UIGestureRecognizerDelegate>

/// 自定义导航栏
@property (nonatomic, strong) SCCustomNavigationBar *navBar;

/// 进度条
@property (nonatomic, strong) UIProgressView *progressView;

/// webview
@property (nonatomic, strong) WKWebView *wkWebView;

/// OC与JS交互桥
@property (nonatomic, strong) WKWebViewJavascriptBridge *bridge;

/// kvo观察者第三方
@property (nonatomic, strong) FBKVOController *KVOController;

@end

@implementation SCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
    [self setupData];
    // Do any additional setup after loading the view.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)setupView {
    [self.view addSubview:self.navBar];
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.progressView];
    [self setupLayout];
}

- (void)setupLayout {
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(self.navBar.statusBarHeight + self.navBar.navBarContentHeight);
    }];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.equalTo(self.navBar.mas_bottom).offset(0);
    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.navBar.mas_bottom).offset(0);
        make.height.mas_equalTo(2.0);
    }];
}

- (void)setupData {
    [self registerAllHandler];
    [self setUpKVOMethods];
    [self loadH5FromServer];
}

/// 进度条的观察者
- (void)setUpKVOMethods {
    self.KVOController = [FBKVOController controllerWithObserver:self];
    __weak typeof(self) weakSelf = self;
    [self.KVOController observe:self.wkWebView keyPath:@"estimatedProgress" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(SCWebViewController *vc, WKWebView *wkWebView, NSDictionary *change) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        CGFloat progress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (progress == 1.0) {
            strongSelf.progressView.hidden = YES;
            [strongSelf.progressView setProgress:0 animated:NO];
        } else {
            strongSelf.progressView.hidden = NO;
            [strongSelf.progressView setProgress:progress animated:YES];
        }
    }];
    
    [self.KVOController observe:self.wkWebView keyPath:@"title" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.wkWebView.title && strongSelf.wkWebView.title.length > 0) {
            strongSelf.title = strongSelf.wkWebView.title;
        }
    }];
}

/// 进行所有的js拦截注册
- (void)registerAllHandler {
    __weak typeof(self) weakSelf = self;
    // 更改nav标题
    [self.bridge registerHandler:@"_app_setTitle" handler:^(id data, WVJBResponseCallback responseCallback) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if ([data isKindOfClass:[NSString class]]) {
            strongSelf.navBar.title = (NSString *)data;
            return ;
        }
        if (data) {
            strongSelf.navBar.title = [NSString stringWithFormat:@"%@",data];
        }
    }];
    
    // 扫一扫
    [self.bridge registerHandler:@"_app_scan" handler:^(id data, WVJBResponseCallback responseCallback) {
        
    }];
    // 返回
    [self.bridge registerHandler:@"sc_app_back" handler:^(id data, WVJBResponseCallback responseCallback) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf dismissViewControllerAnimated:YES completion:^{
            strongSelf.completeHandler(@{});
        }];
    }];
    // 领料
    [self.bridge registerHandler:@"goToMaterial" handler:^(id data, WVJBResponseCallback responseCallback) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.completeHandler(@{@"key" : kGotoMaterialKey, @"data" : data});
        [strongSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    // 打开浏览器
    [self.bridge registerHandler:@"sc_app_browser" handler:^(id data, WVJBResponseCallback responseCallback) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf openBrowser:data];
    }];
}

/// 返回
- (void)backAction {
    if ([self.wkWebView canGoBack]) {
        [self.wkWebView goBack];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/// 关闭
- (void)closeAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}
     
/// 打开浏览器
- (void)openBrowser:(NSString *)url {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ISNULL(url)] options:[[NSDictionary alloc] init] completionHandler:nil];
}

///  加载H5页面
- (void)loadH5FromServer {
    NSString *baseUrlString = self.urlString;
    
    if (baseUrlString != NULL && baseUrlString.length > 0) {
        // url encode编码
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored"-Wdeprecated-declarations"
        baseUrlString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)baseUrlString,(CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",NULL,kCFStringEncodingUTF8));
        #pragma clang diagnostic pop
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:baseUrlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
        [self.wkWebView loadRequest:request];
    } else {
        // 网页地址为空
    }
}

#pragma mark - Delegate Method
/// 必须这样写UIAlert才会显示  completionHandler();不可少
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(nonnull NSString *)message initiatedByFrame:(nonnull WKFrameInfo *)frame completionHandler:(nonnull void (^)(BOOL))completionHandler {
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    // 不执行前段界面弹出列表的JS代码
    [self.wkWebView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    [self.wkWebView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';"completionHandler:nil];
}

/// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    //    self.title = NSLocalizedString(@"Loading...", @"");
}

/// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0 animated:NO];
    self.progressView.hidden = YES;
}

/// 处理网页回调
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 处理电话打断Progress
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme isEqualToString:@"tel"]) {// 处理电话
        [self.progressView setProgress:0 animated:NO];
        self.progressView.hidden = YES;
        NSString *resourceSpecifier = [URL resourceSpecifier];
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", resourceSpecifier];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        });
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}


-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (!navigationAction.targetFrame.isMainFrame) {
        //支持链接中带target=_blank的跳转
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark - UIGestureRecognizerDelegate
/// 是否支持多时候触发，返回YES，则可以多个手势一起触发方法，返回NO则为互斥
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

/// 长按手势事件
- (void)longPressAction:(UILongPressGestureRecognizer *)tap {
    //手势识别开始
    if (tap.state != UIGestureRecognizerStateBegan) {
        return;
    }
    CGPoint touchPoint = [tap locationInView:self.wkWebView];
    // 获取长按位置对应的图片url的JS代码
    NSString *imgJS = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
    // 执行对应的JS代码 获取url
    [self.wkWebView evaluateJavaScript:imgJS completionHandler:^(id _Nullable imgUrl, NSError * _Nullable error) {
        if (imgUrl) {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
            UIImage *image = [UIImage imageWithData:data];
            [self presentImageHandleController:image];
        }
    }];
}

/// 弹出分享、保存弹窗
- (void)presentImageHandleController:(UIImage *)image {
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *saveImageAction = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }];
        [alertCon addAction:cancelAction];
        [alertCon addAction:saveImageAction];
        [self presentViewController:alertCon animated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        // 保存图片失败
    } else {
        // 保存图片成功
    }
}

- (SCCustomNavigationBar *)navBar {
    if (!_navBar) {
        __weak typeof(self) weakSelf = self;
        _navBar = [[SCCustomNavigationBar alloc] init];
        _navBar.title = self.titleString;
        _navBar.backHandler = ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf backAction];
        };
        _navBar.closeHandler = ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf closeAction];
        };
    }
    return _navBar;
}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView= [[WKWebView alloc] initWithFrame:self.view.bounds];
        _wkWebView.backgroundColor = [UIColor whiteColor];
        _wkWebView.scrollView.showsVerticalScrollIndicator = NO;
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
    }
    return _wkWebView;
}

- (WKWebViewJavascriptBridge *)bridge {
    if (!_bridge) {
        _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.wkWebView];
        [_bridge setWebViewDelegate:self];
    }
    return _bridge;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 2.0)];
        _progressView.tintColor = HEXCOLOR(0x4285F4);
        _progressView.trackTintColor = [UIColor whiteColor];
    }
    return _progressView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
