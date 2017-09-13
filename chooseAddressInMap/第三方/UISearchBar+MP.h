//
//  UISearchBar+MP.h
//  psplatform
//
//  Created by plum on 17/3/8.
//  Copyright © 2017年 plum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (MP)
- (void)setupSearchBarSearchImage:(UIImage *)image;

- (void)setupCancleBtnWithColor:(UIColor *)textColor andBackColor:(UIColor *)backColor andFontSize:(BOOL)fontsize;
- (void)setupSearchControllerCancleBtnWithColor:(UIColor *)textColor andBackColor:(UIColor *)backColor andFontSize:(CGFloat)fontsize;

-(void)setupSearchBarBackColor:(UIColor *)backColor;

- (void)setSearchTextFieldBackgroundColor:(UIColor *)backgroundColor;

@end
