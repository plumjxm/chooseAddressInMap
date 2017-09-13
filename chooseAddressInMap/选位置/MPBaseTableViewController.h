//
//  MPBaseTableViewController.h
//  qiantu
//
//  Created by plum on 16/11/26.
//  Copyright © 2016年 plum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHRefreshControl.h"

@interface MPBaseTableViewController : UITableViewController

@property (copy,nonatomic) NSString *titleStr;
@property (strong,nonatomic) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *dataTempArr;
@property (assign,nonatomic) BOOL canAdd;
-(void)layerModelDataWithArr:(NSArray *)models;

/**
 *  创建tableview
 * style tableview的样式 0:plain  1:group
 */
-(void)initBaseTableViewWithStyle:(int)style;

-(void)layeNextPage;
-(void)layeNextPageWithNoDataTitle:(NSString *)title;
-(void)layerTableFootViewWithTitle:(NSString *)titlestr andFootViewH:(CGFloat)height;
- (void)setUpTableFootViewWithTitle:(NSString *)titlestr andFootViewH:(CGFloat)height;

/**
 *  刷新数据
 */
- (void)loadMoreData;
- (void)loadNewData;

/**  刷新控件*/
@property (nonatomic, strong) XHRefreshControl *refreshCtrol;

/*
 * 上/下拉 刷新
 */
- (void)setUpRefreshViewWithView:(UIScrollView *)vi;
/*
 * 上/下拉 停止
 */
- (void)baseEndRefresh;


/**
 *  是否支持上拉刷新
 */
@property (nonatomic, assign) BOOL loadMoreRefreshed;
/**
 *  是否支持下拉刷新
 */
@property (nonatomic, assign) BOOL pullDownRefreshed;

/**
 *  控件 创建
 */
- (UIImageView*)getImageView;
- (UILabel *)creatLabelWithTextColor:(UIColor *)color andTextFont:(UIFont *)font andFrame:(CGRect)frame;
- (UIButton*)getButton;
- (UIButton *)rl_BarBtnWithImageName:(NSString *)imgName WithIsRightBar:(BOOL)isrightBar WithImgW:(CGFloat)imgWW;
- (UIButton *)rl_BarBtnWithTitle:(NSString *)titleStr;



- (void)initTaVCWithUid:(NSString *)uid andUsername:(NSString *)username andAvatar:(NSString *)avatar;
@end
