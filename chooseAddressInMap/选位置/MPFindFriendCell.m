//
//  MPFindFriendCell.m
//  honghong
//
//  Created by manpaoPlum on 15/3/5.
//  Copyright (c) 2015年 localhost. All rights reserved.
//

#import "MPFindFriendCell.h"

@interface MPFindFriendCell ()


@end
@implementation MPFindFriendCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.detailTextLabel.textColor = [UIColor grayColor];
        
    }
    return self;
    
}

#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MPFindFriendCell";
    MPFindFriendCell *cell = (MPFindFriendCell*)[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[MPFindFriendCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
#pragma mark - cell height
+ (CGFloat)getCellHeight
{
    
    return 65;
    
}
@end
