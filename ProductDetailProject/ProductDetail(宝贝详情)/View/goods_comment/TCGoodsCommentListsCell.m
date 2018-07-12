

#import "TCGoodsCommentListsCell.h"
//#import "NSString+HXExtension.h"
#import "03 Constant.h"
#import "02 Macro.h"
#import "UIImageView+WebCache.h"

@interface TCGoodsCommentListsCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *commentLab;
@property (weak, nonatomic) IBOutlet UILabel *attarLab;
@property (weak, nonatomic) IBOutlet UIView *imgsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgsViewHConstraint;

@end

@implementation TCGoodsCommentListsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    ViewRadius(_iconImage, 17.5);
}

- (void)setCommentModel:(Comment *)commentModel {
    _commentModel = commentModel;
    
    __weak typeof(self) _weakSelf = self;
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", URL_IMG_PREFIX, commentModel.avatar]] placeholderImage:ZHENG_HOLDER_IMAGE completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone) {
            _weakSelf.iconImage.alpha = 0;
            [UIView animateWithDuration:1.0 animations:^{
                _weakSelf.iconImage.alpha = 1.0f;
            }];
        } else {
            _weakSelf.iconImage.alpha = 1.0f;
        }
    }];
    
    _nameLab.text = commentModel.buyer_name;
//    _timeLab.text = [NSString changeTimeStampToYMDTime:s_Integer(commentModel.comment_time)];
    _commentLab.text = commentModel.comment;
    _attarLab.text = commentModel.specification;
    
    if (commentModel.images.count) {
        _imgsViewHConstraint.constant = 85;
        for (int i = 0; i < commentModel.images.count; i++) {
            UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:GOODS_PLACE_HOLDER]];
            img.frame = CGRectMake((i *70 *TCRatio) + i *10, 10, 70 *TCRatio, 70 *TCRatio);
            [_imgsView addSubview:img];
            img.userInteractionEnabled = YES;
//            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImgDeailty:)];
//            [_imgsView addGestureRecognizer:tapGes];
        }
    } else {
        _imgsViewHConstraint.constant = 0;
    }
}

@end
