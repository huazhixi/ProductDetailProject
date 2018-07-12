
#import "HRBaseViewController.h"

@interface HRBaseViewController ()

//导航标题颜色
@property (strong, nonatomic) UIColor *titleColor;
//导航标题字体
@property (strong, nonatomic) UIFont *titleFont;
//leftItem 点击回调
@property (copy, nonatomic) void(^leftItemActionBlock)();
//leftItems 点击回调
@property (copy, nonatomic) void(^leftItemsActionBlock)(NSInteger index);
//rightItem 点击回调
@property (copy, nonatomic) void(^rightItemActionBlock)();
//rightItems 点击回调
@property (copy, nonatomic) void(^rightItemsActionBlock)(NSInteger index);

@end

@implementation HRBaseViewController

#pragma mark - ---------- Lifecycle ----------
//视图加载完毕
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeBaseViewControllerData];
    [self configBaseViewControllerControl];
    [self handlerVersionConfig];
}
//内存警告
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"⚠️⚠️⚠️%@内存警告⚠️⚠️⚠️", NSStringFromClass([self class]));
}

#pragma mark - ---------- Private Methods ----------
//初始化数据
- (void)initializeBaseViewControllerData {
    //默认导航标题颜色和字体
    self.titleColor = [UIColor whiteColor];
    self.titleFont  = [UIFont systemFontOfSize:17];
}
//配置基类控件
- (void)configBaseViewControllerControl {}

//处理版本问题
- (void)handlerVersionConfig
{
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (HRBaseViewController *(^)(NSDictionary *attarDic))setupNavAttar {
    return ^(NSDictionary *attarDic) {
      [self.navigationController.navigationBar setTitleTextAttributes:attarDic];
        return self;
    };
}

#pragma mark - ---------- Public Methods ----------
//1.1.1 导航标题文本
- (void)setNaviTitle:(NSString *)naviTitle {
    self.navigationItem.title = naviTitle;
}
//1.1.2 标题文本、颜色、字体
- (void)naviTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font {
    self.navigationItem.title = title;
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:font}];
}
- (HRBaseViewController *(^)(NSString *title))setupNaviTitle {
    return ^(NSString *title) {
        self.navigationItem.title = title;
        return self;
    };
}
- (HRBaseViewController *(^)(UIColor *))setupTitleColor {
    return ^(UIColor *color) {
        self.titleColor = color;
        [self.navigationController.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName:self.titleColor, NSFontAttributeName:self.titleFont}];
        return self;
    };
}
- (HRBaseViewController *(^)(UIFont *))setupTitleFont {
    return ^(UIFont *font) {
        self.titleFont = font;
        [self.navigationController.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName:self.titleColor, NSFontAttributeName:self.titleFont}];
        return self;
    };
}

//1.2.1 左按钮标题
- (void)leftItemTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font action:(void(^)())action {
    self.leftItemActionBlock = action;
    UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [itemButton setTitle:title forState:UIControlStateNormal];
    [itemButton setTitleColor:color forState:UIControlStateNormal];
    [itemButton.titleLabel setFont:font];
    [itemButton sizeToFit];
    [itemButton addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:itemButton];
    self.navigationItem.leftBarButtonItem = item;
}

- (HRBaseViewController *(^)(NSString *title, UIColor *color, UIFont *font, void(^action)()))setupLeftTitleItem {
    return ^(NSString *title, UIColor *color, UIFont *font, void(^action)(void)){
        self.leftItemActionBlock = action;
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemButton setTitle:title forState:UIControlStateNormal];
        [itemButton setTitleColor:color forState:UIControlStateNormal];
        [itemButton.titleLabel setFont:font];
        [itemButton sizeToFit];
        [itemButton addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:itemButton];
        self.navigationItem.leftBarButtonItem = item;
        return self;
    };
}

//1.2.2 左按钮图片
- (void)leftImageItem:(NSString *)imageName action:(void(^)())action{
    self.leftItemActionBlock = action;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction:)];
    self.navigationItem.leftBarButtonItem = item;
}
- (HRBaseViewController *(^)(NSString *imageName, void(^action)()))setupLeftImageItem {
    return ^(NSString *imageName, void(^action)()){
        self.leftItemActionBlock = action;
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction:)];
        self.navigationItem.leftBarButtonItem = item;
        return self;
    };
}

//1.2.3 左按钮通用
- (void)leftItems:(NSArray <HRBarItem *>*)items actions:(void(^)(NSInteger index))actions {
    self.leftItemsActionBlock = actions;
    NSMutableArray *barButtonItems = [NSMutableArray array];
    [items enumerateObjectsUsingBlock:^(HRBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:obj];
        obj.tag = idx;
        [obj addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [barButtonItems addObject:item];
        if (obj.frame.size.width == 0) {
            [obj sizeToFit];
        }
    }];
    self.navigationItem.leftBarButtonItems = barButtonItems;
}
- (HRBaseViewController *(^)(NSArray <HRBarItem *>*items,void (^actions)(NSInteger index)))setupLeftItems {
    return ^(NSArray <HRBarItem *>*items,void (^actions)(NSInteger index)){
        self.leftItemsActionBlock = actions;
        NSMutableArray *barButtonItems = [NSMutableArray array];
        [items enumerateObjectsUsingBlock:^(HRBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:obj];
            obj.tag = idx;
            [obj addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
            [barButtonItems addObject:item];
            if (obj.frame.size.width == 0) {
                [obj sizeToFit];
            }
        }];
        self.navigationItem.leftBarButtonItems = barButtonItems;
        return self;
    };
}

//1.3.1 右按钮标题
- (void)rightItemTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font action:(void(^)())action {
    self.rightItemActionBlock = action;
    UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [itemButton setTitle:title forState:UIControlStateNormal];
    [itemButton setTitleColor:color forState:UIControlStateNormal];
    [itemButton.titleLabel setFont:font];
    [itemButton sizeToFit];
    [itemButton addTarget:self action:@selector(rightItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:itemButton];
    self.navigationItem.rightBarButtonItem = item;
}
- (HRBaseViewController *(^)(NSString *title, UIColor *color, UIFont *font, void(^action)()))setupRightTitleItem {
    return ^(NSString *title, UIColor *color, UIFont *font, void(^action)()) {
        self.rightItemActionBlock = action;
        return self;
    };
}

//1.3.2 右按钮图片
- (void)rightImageItem:(NSString *)imageName action:(void(^)())action {
    self.rightItemActionBlock = action;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = item;
}
- (HRBaseViewController *(^)(NSString *imageName, void(^action)()))setupRightImageItem {
    return ^(NSString *imageName, void(^action)()){
        self.rightItemActionBlock = action;
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
        self.navigationItem.rightBarButtonItem = item;
        return self;
    };
}

//1.3.3 右按钮通用
- (void)rightItems:(NSArray <HRBarItem *>*)items actions:(void(^)(NSInteger index))actions{
    self.rightItemsActionBlock = actions;
    NSMutableArray *barButtonItems = [NSMutableArray array];
    [items enumerateObjectsUsingBlock:^(HRBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:obj];
        obj.tag = idx;
        [obj addTarget:self action:@selector(rightItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [barButtonItems addObject:item];
        if (obj.frame.size.width == 0) {
            [obj sizeToFit];
        }
    }];
    self.navigationItem.rightBarButtonItems = barButtonItems;
}
- (HRBaseViewController *(^)(NSArray <HRBarItem *>*items,void (^actions)(NSInteger index)))setupRightItems {
    return ^(NSArray <HRBarItem *>*items,void (^actions)(NSInteger index)){
        self.rightItemsActionBlock = actions;
        NSMutableArray *barButtonItems = [NSMutableArray array];
        [items enumerateObjectsUsingBlock:^(HRBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:obj];
            obj.tag = idx;
            [obj addTarget:self action:@selector(rightItemAction:) forControlEvents:UIControlEventTouchUpInside];
            [barButtonItems addObject:item];
            if (obj.frame.size.width == 0) {
                [obj sizeToFit];
            }
        }];
        self.navigationItem.rightBarButtonItems = barButtonItems;
        return self;
    };
}

//1.4.1 系统返回按钮隐藏
- (void)setHiddenBackItem:(BOOL)hiddenBackItem {
    self.navigationItem.hidesBackButton = hiddenBackItem;
}
- (HRBaseViewController *(^)())setupHiddenBackItem {
    return ^{
        self.navigationItem.hidesBackButton = YES;
        return self;
    };
}

#pragma mark - ---------- Actions ----------
//leftItem 点击事件
- (void)leftItemAction:(UIButton *)sender {
    if (self.leftItemsActionBlock) {
        self.leftItemsActionBlock(sender.tag);
    }
    if (self.leftItemActionBlock) {
        self.leftItemActionBlock();
    }
}
//rightItem 点击事件
- (void)rightItemAction:(UIButton *)sender {
    if (self.rightItemActionBlock) {
        self.rightItemActionBlock();
    }
    if (self.rightItemsActionBlock) {
        self.rightItemsActionBlock(sender.tag);
    }
}

@end
