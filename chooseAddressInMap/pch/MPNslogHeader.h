//
//  JXTPrefixHeader.pch
//  MyNSLog
//
//  Created by JXT on 16/2/1.
//  Copyright © 2016年 JXT. All rights reserved.
//

#ifndef MPNslogHeader_h
#define MPNslogHeader_h

// Include any system framework and library headers here that should be included in all compilation units.
// You will also need to set the Prefix Header build setting of one or more of your targets to reference this file.

/**
 *  工程全局环境控制
 *
 *  0:开发环境  1:发布环境  
 */
#define MY_PROJECT_GLOBAL_CONTROL 0


#if (MY_PROJECT_GLOBAL_CONTROL == 0)
#define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#define DeBugLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define NSLog(...) NSLog(__VA_ARGS__);
#define MyNSLog(FORMAT, ...) fprintf(stderr,"[%s]:[line %d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#endif

#if (MY_PROJECT_GLOBAL_CONTROL == 1)
#define DLog(...)
#define DeBugLog(...)
#define NSLog(...)
#define MyNSLog(FORMAT, ...) nil
#endif


#endif
