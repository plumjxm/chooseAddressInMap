//
//  MPAddNewAddressVC.h
//  ershizhongop
//
//  Created by plum on 17/8/9.
//  Copyright © 2017年 plum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MPAddNewAddressVC : UIViewController
@property (nonatomic, strong) CLLocation *dingLocation;
@property (copy,nonatomic) NSString *namestr;


typedef void (^AddressSuccessBlock)(NSString *name,CGFloat latitude,CGFloat longitude);
@property(nonatomic,copy)AddressSuccessBlock returnBlock;
@end
