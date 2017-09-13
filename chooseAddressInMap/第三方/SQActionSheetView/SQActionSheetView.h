//
//  SQActionSheetView.h
//  JHTDoctor
//
//  Created by yangsq on 2017/5/23.
//  Copyright © 2017年 yangsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQActionSheetView : UIView

@property (nonatomic, copy) void(^buttonClick)(SQActionSheetView *sheetView,NSInteger buttonIndex);

- (id)initWithTitle:(NSString *)title buttons:(NSArray <NSString *>*)buttons buttonClick:(void(^)(SQActionSheetView *sheetView,NSInteger buttonIndex))block;

- (void)showView;
@end
