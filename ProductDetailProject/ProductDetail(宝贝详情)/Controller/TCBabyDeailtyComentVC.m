/*
 宝贝详情评论
 */

#import "TCBabyDeailtyComentVC.h"
#import "TCBabyDeailtyCommentListVC.h"
//#import "UIImage+ColorCreateImage.h"


@interface TCBabyDeailtyComentVC ()<LLSegmentBarDelegate>

@property (nonatomic,strong)LLSegmentBarVC *segmentVC;
/**     */
@property (strong, nonatomic) TCBabyDeailtyCommentListVC *vc1;
/**     */
@property (strong, nonatomic) TCBabyDeailtyCommentListVC *vc2;
/**     */
@property (strong, nonatomic) TCBabyDeailtyCommentListVC *vc3;
/**     */
@property (strong, nonatomic) TCBabyDeailtyCommentListVC *vc4;
/**     */
@property (strong, nonatomic) TCBabyDeailtyCommentListVC *vc5;

@end

@implementation TCBabyDeailtyComentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.baseNavController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#ffffff" alpha:1.0]] forBarMetrics:UIBarMetricsDefault];
    self.segmentBar.alpha = 1.0;
}

-(void)setUI {
    self.segmentVC.segmentBar.frame = CGRectMake(0, kStatusBarAndNavigationBarHeight + 1, SCREEN_WIDTH, 35);
    self.segmentVC.segmentBar.backgroundColor = [UIColor whiteColor];
    self.segmentVC.view.frame = CGRectMake(0, kStatusBarAndNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kStatusBarAndNavigationBarHeight);
    [self.view addSubview:self.segmentVC.view];
    [self.view addSubview:self.segmentVC.segmentBar];
    ;
    NSArray *items = @[@"全部", [NSString stringWithFormat:@"好评(%ld)", _goodsModel.goodCount], [NSString stringWithFormat:@"中评(%ld)", _goodsModel.commonlyCoun],[NSString stringWithFormat:@"差评(%ld)", _goodsModel.badCount],[NSString stringWithFormat:@"有图(%ld)", _goodsModel.pictureCount]];
    _vc1 = [TCBabyDeailtyCommentListVC new];
    _vc2 = [TCBabyDeailtyCommentListVC new];
    _vc3 = [TCBabyDeailtyCommentListVC new];
    _vc4 = [TCBabyDeailtyCommentListVC new];
    _vc5 = [TCBabyDeailtyCommentListVC new];
    _vc1.goodsID = _goodsID;
    _vc1.type = @"1";
    _vc2.goodsID = _goodsID;
    _vc2.type = @"2";
    _vc3.goodsID = _goodsID;
    _vc3.type = @"3";
    _vc4.goodsID = _goodsID;
    _vc4.type = @"4";
    _vc5.goodsID = _goodsID;
    _vc5.type = @"5";
    
    [self.segmentVC setUpWithItems:items childVCs:@[_vc1, _vc2, _vc3, _vc4, _vc5]];
    
    [self.segmentVC.segmentBar updateWithConfig:^(LLSegmentBarConfig *config) {
        config.itemNormalColor(RGB0X(0x333333)).itemSelectColor(RGB0X(0xd5110c)).indicatorColor(RGB0X(0xd5110c));
    }];
}

- (LLSegmentBarVC *)segmentVC{
    if (!_segmentVC) {
        _segmentVC = [[LLSegmentBarVC alloc]init];
        [self addChildViewController:_segmentVC];
    }
    return _segmentVC;
}

@end
