


#ifndef Macro_h
#define Macro_h

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)

#define UI_IS_IPHONE4           (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height < 568.0)

#define UI_IS_IPHONE5           (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)

#define UI_IS_IPHONE_PLUS       (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0 || [[UIScreen mainScreen] bounds].size.width == 736.0)

#define kIs_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//导航栏高度
#define kStatusBarAndNavigationBarHeight (kIs_iPhoneX ? 88.f : 64.f)
//状态栏高度
#define kStatusBarHeight (kIs_iPhoneX ? 44.f : 20.f)
// Tabbar height.
#define  kTabbarHeight         (kIs_iPhoneX ? (49.f+34.f) : 49.f)// Tabbar safe bottom margin.
#define  kTabbarSafeBottomMargin         (kIs_iPhoneX ? 34.f : 0.f)
#define  Padding  10
#define  BigPadding  15
#define  SmallPadding  5

// View 坐标(x,y)和宽高(width,height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)

#define RECT_CHANGE_x(v,x)          CGRectMake(x, Y(v), WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_y(v,y)          CGRectMake(X(v), y, WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_point(v,x,y)    CGRectMake(x, y, WIDTH(v), HEIGHT(v))
#define RECT_CHANGE_width(v,w)      CGRectMake(X(v), Y(v), w, HEIGHT(v))
#define RECT_CHANGE_height(v,h)     CGRectMake(X(v), Y(v), WIDTH(v), h)
#define RECT_CHANGE_size(v,w,h)     CGRectMake(X(v), Y(v), w, h)


//项目主题颜色
#define THEME_COLOR    RGB0X(0Xff00aa)

// 图片名称
#define IMAGE(string) [UIImage imageNamed:string]

#define TCMargin 10

#define ZHENG_HOLDER_IMAGE [UIImage imageNamed:GOODS_PLACE_HOLDER]
#define GOODS_PLACE_HOLDER @"goodsPlaceHolderImage"
#define GOODS_SCROLL_HODLER_IMAGE @"goodsScrollHolderImage"
#define HENG_HOLDERIMG @"hPlaceHolderImage"
#define SHU_HOLDERIMG @"vPlaceHolderImage"
#define Gray_Shop_Image @"orderShopImg"
#define User_Avater_Image @"userIcon"


#define Now_Longitude [[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"]
#define Now_Latitude [[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"]

#endif /* Macro_h */
