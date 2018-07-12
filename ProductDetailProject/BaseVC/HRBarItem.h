
/*~!
 | @FUNC  导航左右item专用类
 | @AUTH  Nobility
 | @DATE  2016-10-17
 | @BRIF  <#brif#>
 */

#import <UIKit/UIKit.h>

@interface HRBarItem : UIButton

/*!
 *  @author Nobility, 16-09-06 11:09:36
 *
 *  @brief frame
 *
 *  @since 1.0.0
 */
- (HRBarItem *(^)(CGRect))setupFrame;
/*!
 *  @author Nobility, 16-09-06 10:09:54
 *
 *  @brief 标题
 *
 *  @since 1.0.0
 */
- (HRBarItem *(^)(NSString *))setupTitle;

/*!
 *  @author Nobility, 16-09-06 10:09:02
 *
 *  @brief 标题颜色
 *
 *  @since 1.0.0
 */
- (HRBarItem *(^)(UIColor *))setupTitleColor;

/*!
 *  @author Nobility, 16-09-06 10:09:10
 *
 *  @brief 字体
 *
 *  @since 1.0.0
 */
- (HRBarItem *(^)(UIFont *))setupFont;

/*!
 *  @author Nobility, 16-09-06 10:09:16
 *
 *  @brief 边距（需要重置frame）
 *
 *  @since 1.0.0
 */
- (HRBarItem *(^)(UIEdgeInsets))setupTitleEdgeInserts;



@end
