//
//  MPAddNewAddressVC.m
//  ershizhongop
//
//  Created by plum on 17/8/9.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "MPAddNewAddressVC.h"

#import "MKMapView+ZoomLevel.h"

@interface MPAddNewAddressVC ()<MKMapViewDelegate,UITextFieldDelegate>

@property (nonatomic, weak) MKMapView *mapView;

@property (weak,nonatomic) UITextField *titleField;
@property (nonatomic, weak) UIImageView *centerView;

@end

@implementation MPAddNewAddressVC
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_titleField resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"创建地点";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIFont *titleFont = SystemFont(16);
    UIButton *okbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okbtn.frame = CGRectMake(0, 0, 50, 44);
    [okbtn setTitleColor:[UIColor grayColor] forState:0];
    [okbtn setTitle:@"确定" forState:0];
    [okbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    okbtn.titleLabel.font = titleFont;
    [okbtn addActionHandler:^(NSInteger tag) {
        if (self.returnBlock) {
            CGPoint touchPoint = CGPointMake(ScreenWidth/2, _mapView.height/2);
            CLLocationCoordinate2D coordinate =
            [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
          
            self.returnBlock(_titleField.text,coordinate.latitude,coordinate.longitude);
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:okbtn];
    
    
    CGFloat left = 15;
    CGFloat top = VIEWTOP +10;
    CGFloat tfH = 42;
    CGFloat width = ScreenWidth - left*2;
    UITextField *urlField = [[UITextField alloc]initWithFrame:CGRectMake(left,top, width, tfH)];
    urlField.borderStyle = UITextBorderStyleRoundedRect;
    urlField.placeholder = @" 创建地点名称";
    //[urlField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    urlField.clipsToBounds = YES;
    urlField.delegate = self;
    urlField.returnKeyType = UIReturnKeyDone;
    urlField.font = [UIFont  systemFontOfSize:15];
    urlField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:urlField];
    self.titleField = urlField;
    urlField.text = _namestr;
    
    
    CGFloat mapTop = _titleField.bottom+10;
    CGFloat mapH = ScreenHeight - mapTop;
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, mapTop, ScreenWidth, mapH)];
    mapView.scrollEnabled = YES;
    mapView.showsUserLocation = NO;
    [mapView setMapType:MKMapTypeStandard];
    mapView.delegate = self;
    mapView.zoomEnabled = YES;
    mapView.rotateEnabled = YES;
    //mapView.showsPointsOfInterest = NO;
    //mapView.showsBuildings = NO;
    [self.view addSubview:mapView];
    self.mapView = mapView;
    
    
    MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D coordinate =  _dingLocation.coordinate;
    pointAnnotation.coordinate =  coordinate;
    //[self.mapView addAnnotation:pointAnnotation];
    [self.mapView setCenterCoordinate:coordinate zoomLevel:14 animated:YES];
    
    
//    UILongPressGestureRecognizer *lpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//    lpress.minimumPressDuration = 0.3;//按0.5秒响应longPress方法
//    lpress.allowableMovement = 10.0;
//    //给MKMapView加上长按事件
//    [mapView addGestureRecognizer:lpress];//mapView是MKMapView的实例
    
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight-40, ScreenWidth, 40)];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.text = @"拖动地图标记坐标";
    contentLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    contentLabel.font = [UIFont systemFontOfSize:16];
    contentLabel.textColor = [UIColor lightTextColor];
    [self.view addSubview:contentLabel];
    
    //88 144
    CGFloat imgW = 88/2;
    CGFloat imgH = 144/2;
    CGFloat IMGL = (ScreenWidth - imgW)/2;
    UIImageView *titleImgView = [[UIImageView alloc]initWithFrame:CGRectMake(IMGL, _mapView.top+_mapView.height/2-imgH/2, imgW, imgH)];
    titleImgView.image = [UIImage imageNamed:@"redPin"];
    //titleImgView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:titleImgView];
    self.centerView = titleImgView;
    
}
- (void)longPress:(UIGestureRecognizer*)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan){  //这个状态判断很重要
        
        [_titleField resignFirstResponder];

        //坐标转换
        CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
        CLLocationCoordinate2D touchMapCoordinate =
        [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
        //这里的touchMapCoordinate.latitude和touchMapCoordinate.longitude就是你要的经纬度，
        //NSLog(@"%f",touchMapCoordinate.latitude);
        //NSLog(@"%f",touchMapCoordinate.longitude);
        [self.mapView removeAnnotations:self.mapView.annotations];
        MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
        pointAnnotation.coordinate =  touchMapCoordinate;
        [self.mapView addAnnotation:pointAnnotation];

    }
}
#pragma mark - delegate:MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        static NSString *navigationCellIdentifier = @"poiAnnotationViewIdentifier";
        MKPinAnnotationView *poiAnnotationView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:navigationCellIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:navigationCellIdentifier];
        }
        poiAnnotationView.canShowCallout = YES;
        poiAnnotationView.selected = YES;
        return poiAnnotationView;
    }
    
    return nil;
}
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    [_titleField resignFirstResponder];
    
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{

}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
}
#pragma mark -
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end
