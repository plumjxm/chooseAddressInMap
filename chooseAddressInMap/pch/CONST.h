//
//  CONST.h
//  WeiHePan
//
//  Created by manpao on 14-5-8.
//  Copyright (c) 2014年 manpao. All rights reserved.
//

#ifndef WeiHePan_CONST_h
#define WeiHePan_CONST_h
#ifdef __OBJC__


#define  VERSION  (NSString *)[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define SystemVersion [[UIDevice currentDevice] systemVersion]


#define SystemFont(fontSize)  [UIFont systemFontOfSize:fontSize];
#define SystemBoldFont(fontSize)  [UIFont boldSystemFontOfSize:fontSize];
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

#define  MPNotificationCenter  [NSNotificationCenter defaultCenter]
#define  MPApplication [UIApplication sharedApplication]

#define WINDOW [MPApplication keyWindow]
//AppDelegate对象
#define AppDelegateInstance [MPApplication delegate]


#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

#define UserHolderImage  [UIImage imageNamed:@"userHolder"]

#define kStringStr(str) [NSString stringWithFormat:@"%@",str]
//获取图片资源
#define kImageNamed(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
#endif
#endif
