/*
 宝贝详情--图文详情
 */
#import "TCBabyDeailtyWebVC.h"
//#import "UIColor+hex.h"
//#import "UIImage+ColorCreateImage.h"
#import "03 Constant.h"
#import "02 Macro.h"

@interface TCBabyDeailtyWebVC ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *babyDeailtyWeb;

@end

@implementation TCBabyDeailtyWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.babyDeailtyWeb];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.baseNavController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#ffffff" alpha:1.0]] forBarMetrics:UIBarMetricsDefault];
    self.segmentBar.alpha = 1.0;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.baseNavController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#ffffff" alpha:1.0]] forBarMetrics:UIBarMetricsDefault];
    self.segmentBar.alpha = 1.0;
}
- (void)setHtmlStr:(NSString *)htmlStr {
    _htmlStr = htmlStr;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:htmlStr]];
    [self.babyDeailtyWeb loadRequest:request];
}
-(UIWebView *)babyDeailtyWeb
{
    if (!_babyDeailtyWeb) {
        _babyDeailtyWeb = [[UIWebView alloc]initWithFrame:SCREEN_BOUNDS];
        [_babyDeailtyWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_htmlStr]]];
        _babyDeailtyWeb.scrollView.showsHorizontalScrollIndicator =NO;
        _babyDeailtyWeb.delegate = self;
    }
    return _babyDeailtyWeb;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //    2、都有效果
    NSString *js=@"var script = document.createElement('script');"
    "script.type = 'text/javascript';"
    "script.text = \"function ResizeImages() { "
    "var myimg,oldwidth;"
    "var maxwidth = %f;"
    "for(i=0;i <document.images.length;i++){"
    "myimg = document.images[i];"
    "if(myimg.width > maxwidth){"
    "oldwidth = myimg.width;"
    "myimg.width = %f;"
    "}"
    "}"
    "}\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    js=[NSString stringWithFormat:js,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width-15];
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}

@end
