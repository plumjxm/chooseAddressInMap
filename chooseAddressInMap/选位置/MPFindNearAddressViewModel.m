//
//  RequestViewModel.m
//  MVVMJYZ
//
//  Created by jiayazi on 16/11/23.
//  Copyright © 2016年 jiayazi. All rights reserved.
//

#import "MPFindNearAddressViewModel.h"
#import "MPFindFriendCell.h"

#import <AMapSearchKit/AMapSearchKit.h>

#import "MPMapView.h"


@implementation MPFindNearAddressViewModel
#pragma mark -  UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section==0) {
//        return 1;
//    }
    return [self.models count];
    
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 2;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    MPFindFriendCell *cell = [MPFindFriendCell cellWithTableView:tableView];
    cell.textLabel.textColor = [UIColor blackColor];
//    if (indexPath.section==0) {
//        cell.textLabel.text = @"不显示位置";
//        cell.textLabel.textColor = ALLGREENCOLOR;
//        cell.detailTextLabel.text = nil;
//    }else{
        AMapPOI *model = self.models[indexPath.row];
        cell.textLabel.text = model.name;
        cell.detailTextLabel.text = model.address;
//    }
   
    cell.accessoryType = indexPath.row==0?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [MPFindFriendCell getCellHeight];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (self.returnBlock) {
        self.returnBlock(indexPath);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return   CHOOSEMAPVIEWMAPH;
    //return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.tableSectionHeadView;
    
}
- (MPMapView *)tableSectionHeadView
{
    if (_tableSectionHeadView == nil) {
        _tableSectionHeadView = [[MPMapView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, CHOOSEMAPVIEWMAPH)];
    }
    return _tableSectionHeadView;
}
@end
