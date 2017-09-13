//
//  MPFindNearAddressVC.h
//  honghong
//
//  Created by manpaoPlum on 15/3/5.
//  Copyright (c) 2015年 localhost. All rights reserved.
//

#import "MPBaseTableViewController.h"

@interface MPFindNearAddressVC : MPBaseTableViewController
typedef void (^ChooseAddressSuccessBlock)(NSString *city,NSString *name,NSString *address,CGFloat latitude,CGFloat longitude,NSString *phone,UIImage *img);
@property(nonatomic,copy)ChooseAddressSuccessBlock returnBlock;
@end
