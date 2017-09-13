//
//  MPMapView.m
//  tenMS
//
//  Created by plum on 17/8/1.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "MPMapView.h"
#import "MKMapView+ZoomLevel.h"


@interface MPMapView ()

@end

@implementation MPMapView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initView];
        
    }
    return self;
}
#pragma mark - Private
- (void)initView
{
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.bounds];
    mapView.scrollEnabled = NO;
    [mapView setMapType:MKMapTypeStandard];
    //mapView.delegate = self;
    mapView.zoomEnabled = YES;
    mapView.rotateEnabled = YES;
    mapView.showsPointsOfInterest = YES;
    mapView.showsBuildings = NO;
    [self addSubview:mapView];
    self.mapView = mapView;
    
}
#pragma mark - Getter

#pragma mark - 
-(void)layerFrameWithTitle:(NSString *)titleStr WithAddress:(NSString *)addressStr andLo:(CLLocationDegrees)Lo andLa:(CLLocationDegrees)la
{
    [self.mapView removeAnnotations:_mapView.annotations];
    MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D _coordinate = CLLocationCoordinate2DMake(la, Lo );
    pointAnnotation.coordinate =  _coordinate;
    //pointAnnotation.title = self.subject;
    //pointAnnotation.subtitle = self.address;
    //[self.mapView selectAnnotation:pointAnnotation animated:YES];//这样就可以在初始化的时候将 气泡信息弹出
    [self.mapView addAnnotation:pointAnnotation];
    [self.mapView setCenterCoordinate:_coordinate zoomLevel:13 animated:NO];


}
@end
