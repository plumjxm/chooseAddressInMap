//
//  RequestViewModel.h
//  MVVMJYZ
//
//  Created by jiayazi on 16/11/23.
//  Copyright © 2016年 jiayazi. All rights reserved.
//

#import <Foundation/Foundation.h>

//为要声明的Block重新定义了一个名字
typedef void (^DidSelectRowAtIndexPathBlock)(NSIndexPath *indexPath);
typedef void (^ScrollViewDidScrollBlock)();
typedef void (^ScrollViewWillBeginDraggingBlock)();

@interface RequestViewModel : NSObject<UITableViewDelegate,UITableViewDataSource>

/**
 *  模型数组
 */
@property (nonatomic, strong) NSArray *models;

-(id)initWithSelectBlock:(DidSelectRowAtIndexPathBlock)block;
@property(nonatomic,copy)DidSelectRowAtIndexPathBlock returnBlock;
@property(nonatomic,copy)ScrollViewDidScrollBlock didScrollBlock;
@property(nonatomic,copy)ScrollViewWillBeginDraggingBlock willDragBlock;


@end
