//
//  UIImage+scaleimage.h
//  yinhua
//
//  Created by manpao on 15/3/4.
//  Copyright (c) 2015年 manpaoTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MP)
/** 截取当前image对象rect区域内的图像*/
+(UIImage*)subimageInRect:(UIImage *)image rect:(CGRect)rect;
+ (UIImage *)imageWithColor:(UIColor *)color;


- (UIImage *)scaleToSize:(CGSize)size;
- (UIImage *)fixOrientation;
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;
//压缩图片到 ?k
-(UIImage *)scaleImageToKb:(NSInteger)kb;


/** 上传图片 post参数*/
- (NSMutableDictionary *)getUpLoadImageParmWithImage;
- (NSData *)uploadImgScaleImage;
@end
