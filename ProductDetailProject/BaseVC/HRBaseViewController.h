
#import <UIKit/UIKit.h>
#import "HRBarItem.h"
#import "HRBaseViewControllerProtocol.h"

@interface HRBaseViewController : UIViewController <HRBaseViewControllerProtocol>

#pragma mark 1 导航
//1.1.1 导航标题文本
@property (copy, nonatomic) NSString *naviTitle;
//1.1.2 标题文本、颜色、字体
- (void)naviTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font;
- (HRBaseViewController *(^)(NSString *title))setupNaviTitle;
- (HRBaseViewController *(^)(UIColor *))setupTitleColor;
- (HRBaseViewController *(^)(UIFont *))setupTitleFont;

//1.2.1 左按钮标题
- (void)leftItemTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font action:(void(^)())action;
- (HRBaseViewController *(^)(NSString *title, UIColor *color, UIFont *font, void(^action)()))setupLeftTitleItem;

//1.2.2 左按钮图片
- (void)leftImageItem:(NSString *)imageName action:(void(^)())action;
- (HRBaseViewController *(^)(NSString *imageName, void(^action)()))setupLeftImageItem;

//1.2.3 左按钮通用
- (void)leftItems:(NSArray <HRBarItem *>*)items actions:(void(^)(NSInteger index))actions;
- (HRBaseViewController *(^)(NSArray <HRBarItem *>*items,void (^actions)(NSInteger index)))setupLeftItems;

//1.3.1 右按钮标题
- (void)rightItemTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font action:(void(^)())action;
- (HRBaseViewController *(^)(NSString *title, UIColor *color, UIFont *font, void(^action)()))setupRightTitleItem;

//1.3.2 右按钮图片
- (void)rightImageItem:(NSString *)imageName action:(void(^)())action;
- (HRBaseViewController *(^)(NSString *imageName, void(^action)()))setupRightImageItem;

//1.3.3 右按钮通用
- (void)rightItems:(NSArray <HRBarItem *>*)items actions:(void(^)(NSInteger index))actions;
- (HRBaseViewController *(^)(NSArray <HRBarItem *>*items,void (^actions)(NSInteger index)))setupRightItems;

//1.4.1 系统返回按钮隐藏
@property (assign, nonatomic) BOOL hiddenBackItem;
- (HRBaseViewController *(^)())setupHiddenBackItem;

//2.1.1 显示没有数据页面（预留）
//
//2.1.2 移除没有数据页面（预留）
//
//2.2.1 加载视图（预留）
//
//2.2.2 停止加载（预留）
//
//2.3.1 登录检测（预留）
//
//2.4.1 显示分享内容
//
//2.5.1 状态栏


@end
