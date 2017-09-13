//
//  RequestViewModel.m
//  MVVMJYZ
//
//  Created by jiayazi on 16/11/23.
//  Copyright © 2016年 jiayazi. All rights reserved.
//

#import "RequestViewModel.h"

@implementation RequestViewModel

-(id)initWithSelectBlock:(DidSelectRowAtIndexPathBlock)block{
    if (self = [super init]) {
        self.returnBlock = block;
    }
    return self;
}
#pragma mark--------------------    代理方法     ------------------------------
#pragma mark -  UITableViewData
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell_RequestViewModel";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}
#pragma mark -  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
//- ( UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return  [[UIView alloc]init];
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    return  [[UIView alloc]init];
//    
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.returnBlock) {
        self.returnBlock(indexPath);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
#pragma mark -  scroll deleagte
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.willDragBlock) {
        self.willDragBlock();
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (self.didScrollBlock) {
        self.didScrollBlock();
    }
}

@end
