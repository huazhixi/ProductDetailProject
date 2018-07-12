/*
 宝贝评价列表
 */
#import "TCBabyDeailtyCommentListVC.h"
#import "EasyLoadingView.h"
#import "03 Constant.h"
#import "02 Macro.h"
#import "UITableView+FDTemplateLayoutCell.h"

@implementation TCBabyDeailtyCommentListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.commentListView];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self fetchGoodsCommentData];
}
/**
 刷新页面视图
 */
- (void)fetchGoodsCommentData {
    
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.commentArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TCGoodsCommentListsCell *cell = [tableView dequeueReusableCellWithIdentifier:TCGoodsCommentListsCellID];
    cell.commentModel = self.commentArray[indexPath.section];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:TCGoodsCommentListsCellID cacheByIndexPath:indexPath configuration:^(TCGoodsCommentListsCell *cell) {
        cell.commentModel = self.commentArray[indexPath.row];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

#pragma mark -lazy load
- (NSMutableArray *)commentArray {
    if (!_commentArray) {
        _commentArray  = [[NSMutableArray alloc] init];
    }
    return _commentArray;
}
-(UITableView *)commentListView {
    if (!_commentListView) {
        _commentListView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - kStatusBarAndNavigationBarHeight - 35 - kTabbarSafeBottomMargin) style:UITableViewStyleGrouped];
        _commentListView.delegate   = self;
        _commentListView.dataSource = self;
        _commentListView.allowsSelection = NO;
        _commentListView.showsVerticalScrollIndicator = NO;
        _commentListView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _commentListView.backgroundColor = LINE_BACK_COLOR;
        [_commentListView registerNib:[UINib nibWithNibName:NSStringFromClass([TCGoodsCommentListsCell class]) bundle:nil] forCellReuseIdentifier:TCGoodsCommentListsCellID];
    }
    return _commentListView;
}
@end
