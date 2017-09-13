//
//  ColorHead.h
//  duiban
//
//  Created by Plum on 16/1/19.
//  Copyright © 2016年 ManPao. All rights reserved.
//

#ifndef wh_Head_h
#define wh_Head_h
#ifdef __OBJC__

#define NavItemH 44
#define NavItemW 50

#define LINEH 0.5
#define SEPLINEH  8

//屏幕大小边界
#define ScreenBounds [[UIScreen mainScreen] bounds]
//屏幕高度
#define ScreenHeight ScreenBounds.size.height
//屏幕宽度
#define ScreenWidth ScreenBounds.size.width
#define CHOOSEMAPVIEWMAPH ScreenWidth*3/8

#define NAVHEIGHT 64
#define TABBARHEIGHT 49
#define VIEWHEIGHT   (ScreenHeight - NAVHEIGHT)
#define VIEWTOP 64

#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_MAX_LENGTH (MAX(ScreenWidth, ScreenHeight))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#endif /* wh_Head_h */
#endif
