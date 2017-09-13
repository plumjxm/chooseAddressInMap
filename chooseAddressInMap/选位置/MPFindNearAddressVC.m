//
//  MPAttentionFriendVC.m
//  honghong
//
//  Created by manpaoPlum on 15/3/5.
//  Copyright (c) 2015年 localhost. All rights reserved.
//

#import "MPFindNearAddressVC.h"

#import "MPFindFriendCell.h"

#import "UISearchBar+MP.h"

#import "MPFindNearAddressViewModel.h"


#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

#import "MJRefresh.h"

#import "MPMapView.h"

#import "MPFindFriendCell.h"


#import "MPNoResultHeadView.h"
#import "MPAddNewAddressVC.h"

@interface MPFindNearAddressVC ()<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,MAMapViewDelegate,AMapSearchDelegate>
{
    NSString *_searchTypesStr;
    
    AMapPOIAroundSearchRequest *_aroundSearchRequest;
    
    AMapPOIKeywordsSearchRequest *_keywordsSearchRequest;
    
    UIImage *_shotImg;
    
    AMapPOI *_searchSelectModel;
    
}
//@property (nonatomic, strong) MPMapView *mapView1;

@property (nonatomic, strong) NSMutableArray *searchDataArr;
@property(nonatomic,strong) MPFindNearAddressViewModel *requestViewModel;
@property (nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic,strong) UITableView *searchResultsTableView;
@property (nonatomic, strong) UISearchDisplayController *searchController;


@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) CLLocation *currentLocation;

@property (nonatomic, strong) CLLocation *dingLocation;

@property (strong,nonatomic) UIActivityIndicatorView *reloadView;
@property (strong,nonatomic) UIView *reloadBGView;

@end

@implementation MPFindNearAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //050000 餐饮服务;餐饮相关场所;餐饮相关
    //060000 购物服务;购物相关场所;购物相关场所
    //070000 生活服务;生活服务场所;生活服务场所
    //080000 体育休闲服务;体育休闲服务场所;体育休闲服务场所
    //090000 医疗保健服务;医疗保健服务场所;医疗保健服务场所
    //100000 住宿服务;住宿服务相关;住宿服务相关
    //110000 风景名胜;风景名胜相关;旅游景点
    //120000 商务住宅;商务住宅相关;商务住宅相关
    //130000 政府机构及社会团体;政府及社会团体相关;政府及社会团体相关
    //140000 科教文化服务;科教文化场所;科教文化场所
    //150000 交通设施服务;交通服务相关;交通服务相关
    //160000 金融保险服务;金融保险服务机构;金融保险机构
    //170000 公司企业;公司企业;公司企业
    //180000 道路附属设施;道路附属设施;道路附属设施
    //_searchTypesStr = @"050000|060000|070000|100000|110000|170000";
    _searchTypesStr = @"地名地址信息|餐饮服务|购物服务|生活服务|风景名胜|公司企业";
    //_searchTypesStr = @"地名地址信息";

    [self initNavView];
    [self initTableView];
    
    [self initMapView];
    
    
    //[self.view addSubview:self.reloadBGView];
    [self.view addSubview:self.reloadView];
    _reloadBGView.hidden = YES;

}
#pragma mark - initTableView
- (void)initTableView{
    
    
    UIImageView *imageBack = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageBack.backgroundColor = TABLE_BG_COLOR;
    self.tableView.backgroundView = imageBack;
    
    //self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    //self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    //self.tableView.sectionIndexColor = [UIColor darkGrayColor];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.dataSource = self.requestViewModel;
    self.tableView.delegate = self.requestViewModel;
    self.tableView.backgroundColor = TABLE_BG_COLOR;
    self.tableView.separatorColor = LINECOLOR;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    self.tableView.tableHeaderView = self.searchBar;
    
    
    [self setUpTableFootViewWithTitle:@"定位中..." andFootViewH:60];
    _searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
    [self setUpRefreshViewWithView:self.tableView];
    self.refreshControl = nil;

}
- (void)initNavView
{
    
    self.titleStr = @"所在位置";
    
    UIButton *btn1 = [self rl_BarBtnWithTitle:@"取消"];
    [btn1 addActionHandler:^(NSInteger tag) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    
    
    UIButton *btn = [self rl_BarBtnWithTitle:@"确定"];
    [btn addActionHandler:^(NSInteger tag) {
        if (self.requestViewModel.models.count>0) {
            AMapPOI *model = self.requestViewModel.models[0];
            if (self.returnBlock) {
               
                self.returnBlock(model.city,model.name,model.address,model.location.latitude,model.location.longitude,model.tel,_shotImg);
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            //[self showHoderView:@"还没有选择位置"];
        }
       
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}
//更改tableview样式
- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStylePlain];
}
- (void)initMapView{
    
    
//    _mapView1 = [[MPMapView alloc]initWithFrame:CGRectMake(0, self.tableView.tableHeaderView.height, ScreenWidth, CHOOSEMAPVIEWMAPH)];
//    [self.tableView addSubview:_mapView1];

    
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
    
    _mapView = [[MAMapView alloc]initWithFrame:CGRectZero];;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    
    _mapView.showsUserLocation = YES;
    
    
    _aroundSearchRequest = [[AMapPOIAroundSearchRequest alloc]init];
    _aroundSearchRequest.offset = 30;
    /* 按照距离排序. */
    _aroundSearchRequest.sortrule = 0;
    _aroundSearchRequest.requireExtension  = YES;
    _aroundSearchRequest.types = _searchTypesStr;
    
    
    _keywordsSearchRequest = [[AMapPOIKeywordsSearchRequest alloc]init];
    _keywordsSearchRequest.offset = 50;
    /* 按照距离排序. */
    _keywordsSearchRequest.sortrule = 1;
    _keywordsSearchRequest.requireExtension  = YES;
    _keywordsSearchRequest.cityLimit           = YES;
    _keywordsSearchRequest.requireSubPOIs      = YES;
    _keywordsSearchRequest.types = _searchTypesStr;
    
}
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    _mapView.showsUserLocation = NO;
    _dingLocation = [userLocation.location copy];
    _currentLocation = _dingLocation;
    
    [self.requestViewModel.tableSectionHeadView layerFrameWithTitle:nil WithAddress:nil andLo:_dingLocation.coordinate.longitude andLa:_dingLocation.coordinate.latitude];
    
    [self loadNewData];
    
}
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    [self baseEndRefresh];
    [_reloadView stopAnimating];
    _reloadBGView.hidden = YES;
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if ([request isKindOfClass:[AMapPOIAroundSearchRequest class]]) {
        
        [_reloadView stopAnimating];
        _reloadBGView.hidden = YES;
        [self baseEndRefresh];

        [self layerModelDataWithArr:response.pois];
        
        AMapAOI *model = self.dataArr.firstObject;
        if (_searchSelectModel&&![model.name isEqualToString:_searchSelectModel.name]) {
            [self.dataArr insertObject:_searchSelectModel atIndex:0];
        }
        self.requestViewModel.models = self.dataArr;
        [self.tableView reloadData];
        
        self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        if (self.dataArr.count == 0) {
            self.tableView.footerHidden = YES;
            [self layerTableFootViewWithTitle:@"还没有数据哦" andFootViewH:60];
        }else{
            if (response.pois.count==0) {
                self.tableView.footerHidden = YES;
            }else{
                self.tableView.footerHidden = NO;
            }
        }
        
        [self cutMapImg];

    }
   

    if ([request isKindOfClass:[AMapPOIKeywordsSearchRequest class]]) {
        
        if (response.pois.count==0) {
            MPNoResultHeadView *noResultLabel = [[MPNoResultHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 70)];
             noResultLabel.textStr = [NSString stringWithFormat:@"没有找到?\n在这里添加一个新的地点: \"%@\"",_searchBar.text];
            UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_noResultLabel)];
            [noResultLabel addGestureRecognizer:tap1];
            _searchResultsTableView.tableFooterView = noResultLabel;
        }else{
            UIView *view = [UIView new];
            _searchResultsTableView.tableFooterView = view;
        }
        [_searchDataArr removeAllObjects];
        [_searchDataArr  addObjectsFromArray:response.pois];
        [_searchResultsTableView reloadData];

    }
}
- (void)tap_noResultLabel
{
    MPAddNewAddressVC *vc = [MPAddNewAddressVC new];
    vc.dingLocation = _dingLocation;
    vc.namestr = _searchBar.text;
    [vc setReturnBlock:^(NSString *name,CGFloat latitude,CGFloat longitude){
        if (self.returnBlock) {
            self.returnBlock(nil,name,nil,latitude,longitude,nil,nil);
        }
    
    }];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -
- (void)cutMapImg
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIGraphicsBeginImageContextWithOptions(self.requestViewModel.tableSectionHeadView.bounds.size, NO, 0);
        [self.requestViewModel.tableSectionHeadView.layer renderInContext:UIGraphicsGetCurrentContext()];
        _shotImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    });

 
}
#pragma mark -
- (void)searchRequestNearPIOSWithPage:(NSString *)page
{
    if (_currentLocation==nil||_search==nil) {
        return;
    }
   
    _aroundSearchRequest.location =  [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
    _aroundSearchRequest.page = [page integerValue];
    [self.search AMapPOIAroundSearch:_aroundSearchRequest];
}
- (void)getData:(NSString*)page{
    
    [self searchRequestNearPIOSWithPage:page];
}
#pragma mark -  UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AMapPOI *model = self.searchDataArr[indexPath.row];
    MPFindFriendCell *cell = [MPFindFriendCell cellWithTableView:tableView];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.address;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MPFindFriendCell getCellHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return   0.02;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //UIView *headView = [[UIView alloc]init];
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_searchController setActive:NO animated:YES];

    AMapPOI *model = self.searchDataArr[indexPath.row];
    [self didseletIndex:model andIsSearch:YES];
    
}
- (void)didseletIndex:(AMapPOI *)model andIsSearch:(BOOL)issearch
{
    [_reloadView startAnimating];
    _reloadBGView.hidden = NO;

    _currentLocation =  [[CLLocation alloc]initWithLatitude:model.location.latitude longitude:model.location.longitude];
    [self.requestViewModel.tableSectionHeadView layerFrameWithTitle:nil WithAddress:nil andLo:model.location.longitude andLa:model.location.latitude];
    _searchSelectModel = model;

    if (issearch) {
        [self.tableView scrollToTopAnimated:NO];
    }else{
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    
    [self loadNewData];



}
#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) {
        CGFloat tableCH = self.tableView.contentOffset.y;
        CGFloat tableH = self.tableView.contentSize.height;
        if ( fabs(tableH - tableCH) <  ScreenHeight+64){
            [self.tableView footerBeginRefreshing];
        }
    }
    
}

#pragma mark -  setter and getter

-(MPFindNearAddressViewModel *)requestViewModel
{
    if (!_requestViewModel) {
        _requestViewModel = [[MPFindNearAddressViewModel alloc]initWithSelectBlock:^(NSIndexPath *indexPath) {

                AMapPOI *model = self.dataArr[indexPath.row];
                [self didseletIndex:model andIsSearch:NO];

            
        }];
        //[_requestViewModel setSelfVC:(MPBaseViewController *)self];
    }
    return _requestViewModel;
}
- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
        searchBar.placeholder = @"搜索";
        [searchBar sizeToFit];
        [searchBar setupSearchBarSearchImage:[UIImage imageNamed:@"首页-顶部-搜索"]];

        //searchBar.frame = CGRectMake(0, 0, ScreenWidth, searchBar.height);
        _searchBar = searchBar;
        _searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
        _searchController.searchResultsDataSource = self;
        _searchController.searchResultsDelegate = self;
        _searchController.delegate = self;
        _searchResultsTableView = _searchController.searchResultsTableView;
        [self layoutSearchBar:YES];
        
    }
    return _searchBar;
}
- (NSMutableArray *)searchDataArr
{
    if (_searchDataArr == nil) {
        _searchDataArr = [NSMutableArray new];
    }
    return _searchDataArr;
}

#pragma mark - UISearchDisplayController delegate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self searchMyFriends:searchString];
    
    return YES;
}

- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    [self layoutSearchBar:NO];
}
- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    [self layoutSearchBar:YES];
    
}
- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    [controller.searchBar setupSearchControllerCancleBtnWithColor:nil andBackColor:nil andFontSize:14];
    
    //更改遮罩 透明度 
    UIView *supV = controller.searchResultsTableView.superview;
    UIView *supsupV = supV.superview;
    
    for (UIView *view in supsupV.subviews) {
        for (UIView *sencondView in view.subviews) {
            if ([sencondView isKindOfClass:[NSClassFromString(@"_UISearchDisplayControllerDimmingView") class]])
            {
                NSLog(@"-_UISearchDisplayControllerDimmingView--%f-----",sencondView.alpha);
                sencondView.alpha = 0.25;
                //sencondView.backgroundColor = [UIColor whiteColor];
            }
        }
    }

}

#pragma mark -
-(void)layoutSearchBar:(BOOL)isgray
{
    
    [_searchBar setupSearchBarBackColor:isgray?TABLE_BG_COLOR:[UIColor clearColor]];
    
}


#pragma mark - searchdata
- (void)searchMyFriends:(NSString *)searchStr
{
    
    _keywordsSearchRequest.location =  [AMapGeoPoint locationWithLatitude:_dingLocation.coordinate.latitude longitude:_dingLocation.coordinate.longitude];
    _keywordsSearchRequest.keywords = searchStr;
    [_search AMapPOIKeywordsSearch:_keywordsSearchRequest];
    
}

#pragma mark - Getter
- (UIActivityIndicatorView *)reloadView
{
    if (_reloadView == nil) {
        CGFloat top = self.tableView.tableHeaderView.height+CHOOSEMAPVIEWMAPH;
        CGFloat height = VIEWHEIGHT - top +self.tableView.tableHeaderView.height;
        UIActivityIndicatorView *testActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        testActivityIndicator.backgroundColor = [UIColor whiteColor];
        testActivityIndicator.frame = CGRectMake(0, top, ScreenWidth, height);
        //[testActivityIndicator startAnimating]; // 开始旋转
        //[testActivityIndicator stopAnimating]; // 结束旋转
        [testActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
        _reloadView = testActivityIndicator;
    }
    return _reloadView;
}
- (UIView *)reloadBGView
{

    if (_reloadBGView == nil) {
        _reloadBGView = [[UIView alloc]initWithFrame:self.view.bounds];
        _reloadBGView.backgroundColor = [UIColor whiteColor];

    }
    return _reloadBGView;
}

@end


