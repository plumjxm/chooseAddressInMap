//
//  MPMapView.h
//  tenMS
//
//  Created by plum on 17/8/1.
//  Copyright © 2017年 plum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MPMapView : UIView
-(void)layerFrameWithTitle:(NSString *)titleStr WithAddress:(NSString *)addressStr andLo:(CLLocationDegrees)Lo andLa:(CLLocationDegrees)la;
@property (nonatomic, weak) MKMapView *mapView;

@end
