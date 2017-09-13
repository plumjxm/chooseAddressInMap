//
//  UISearchBar+MP.m
//  psplatform
//
//  Created by plum on 17/3/8.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "UISearchBar+MP.h"

@implementation UISearchBar (MP)
#pragma mark -
- (void)setupSearchBarSearchImage:(UIImage *)image
{
   
    [self setImage:[image imageWithTintColor:[UIColor grayColor]] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];

}

#pragma mark -
- (void)setupSearchControllerCancleBtnWithColor:(UIColor *)textColor andBackColor:(UIColor *)backColor andFontSize:(CGFloat)fontsize
{
    UIView *topView = self.subviews[0];
    for (UIView *subView in topView.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            UIButton *cancelButton = (UIButton*)subView;
            [cancelButton setTitle:@"取消"  forState:UIControlStateNormal];//文字
            if (textColor) {
                // 修改文字颜色
                [cancelButton setTitleColor:textColor forState:UIControlStateNormal];
                [cancelButton setTitleColor:textColor forState:UIControlStateHighlighted];
            }
            if (fontsize) {
                cancelButton.titleLabel.font = [UIFont systemFontOfSize:fontsize];
                
            }
            
            if (backColor) {
                // 修改按钮背景
                [cancelButton setBackgroundImage:[UIImage  imageWithColor:backColor] forState:UIControlStateNormal];
                [cancelButton setBackgroundImage:nil forState:UIControlStateHighlighted];
            }
        }
    }
}
- (void)setupCancleBtnWithColor:(UIColor *)textColor andBackColor:(UIColor *)backColor andFontSize:(BOOL)fontsize
{
    if ([SystemVersion floatValue]<8.0) {
        // 修改UISearchBar右侧的取消按钮文字颜色及背景图片
        for (UIView *searchbuttons in [self subviews]){
            if ([searchbuttons isKindOfClass:[UIButton class]]) {
                UIButton *cancelButton = (UIButton*)searchbuttons;
                [self setCancleBtnAll:cancelButton WithColor:textColor andBackColor:backColor andFontSize:fontsize];
            }
        }
    }else{
        for (id cencelButton in [[self.subviews lastObject] subviews])
        {
            if([cencelButton isKindOfClass:[UIButton class]])
            {
                UIButton *cancelButton = (UIButton *)cencelButton;
                [self setCancleBtnAll:cancelButton WithColor:textColor andBackColor:backColor andFontSize:fontsize];
            }
        }
    }
    
}
- (void)setCancleBtnAll:(UIButton *)cancelButton WithColor:(UIColor *)textColor andBackColor:(UIColor *)backColor andFontSize:(BOOL)fontsize{
    [cancelButton setTitle:@"取消"  forState:UIControlStateNormal];
    if (textColor) {
        
        //if ([cancelButton isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
           // [cancelButton  setTintColor:textColor];
            //[cancelButton.titleLabel setTextColor:textColor];
        //}else{
            // 修改文字颜色
            [cancelButton setTitleColor:textColor forState:UIControlStateNormal];
            [cancelButton setTitleColor:textColor forState:UIControlStateHighlighted];
        //}

    }
    if (fontsize) {
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:fontsize];
        
    }
    
    if (backColor) {
        // 修改按钮背景
        [cancelButton setBackgroundImage:[UIImage  imageWithColor:backColor] forState:UIControlStateNormal];
        [cancelButton setBackgroundImage:nil forState:UIControlStateHighlighted];
        
    }
}
-(void)setupSearchBarBackColor:(UIColor *)backColor
{
    UIImageView *imageView = [self viewWithTag:1000];
    if (imageView==nil) {
        imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        imageView.tag = 1000;
        [self insertSubview:imageView atIndex:1];
    }
    imageView.backgroundColor = backColor;
    
}
- (void)setSearchTextFieldBackgroundColor:(UIColor *)backgroundColor
{
    UIView *searchTextField = nil;
    if ([SystemVersion floatValue] > 7) {
        // 经测试, 需要设置barTintColor后, 才能拿到UISearchBarTextField对象
        self.barTintColor = [UIColor whiteColor];
        searchTextField = [[[self.subviews firstObject] subviews] lastObject];
    } else { // iOS6以下版本searchBar内部子视图的结构不一样
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                searchTextField = subView;
            }
        }
    }
    searchTextField.backgroundColor = backgroundColor;
}

@end
