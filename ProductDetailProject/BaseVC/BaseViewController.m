

#import "BaseViewController.h"
#import "03 Constant.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - ---------- Lazy Loading（懒加载） ----------

#pragma mark - ----------   Lifecycle（生命周期） ----------
//
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB0X(0xf4f4f4);
}
//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - ---------- Private Methods（私有方法） ----------

#pragma mark initliaze data(初始化数据)

#pragma mark config control（布局控件）

#pragma mark networkRequest (网络请求)

#pragma mark actions （点击事件）

#pragma mark IBActions （点击事件xib）

#pragma mark - ---------- Public Methods（公有方法） ----------

#pragma mark self declare （本类声明）

#pragma mark override super （重写父类）
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}


#pragma mark setter （重写set方法）

#pragma mark - ---------- Protocol Methods（代理方法） ----------


@end

