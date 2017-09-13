//
//  UIImage+scaleimage.m
//  yinhua
//
//  Created by manpao on 15/3/4.
//  Copyright (c) 2015年 manpaoTech. All rights reserved.
//

#import "UIImage+MP.h"

@implementation UIImage (MP)

/** 截取当前image对象rect区域内的图像*/
+(UIImage*)subimageInRect:(UIImage *)image rect:(CGRect)rect{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return smallImage;
}
//图片颜色 改变
+ (UIImage *)imageWithColor:(UIColor *)color
{
     return [self imageWithColor:color size:CGSizeMake(1, 1)];
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (UIImage *)imageWithTintColor:(UIColor *)tintColor
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}
//等比例缩放
-(UIImage*)scaleToSize:(CGSize)scaleSize {
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);

    
    CGAffineTransform scaleTransform;
    CGPoint origin;

    CGSize size;
    if (width > height) {
        CGFloat scaleRatio = scaleSize.width / width;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        CGFloat scaleRatio1 = width / height;

        size = CGSizeMake(scaleSize.width,scaleSize.width/scaleRatio1);
    }else{
        CGFloat scaleRatio = scaleSize.height / height;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        CGFloat scaleRatio1 = height / width;
        size = CGSizeMake(scaleSize.height/scaleRatio1,scaleSize.height);

    }
    
    origin = CGPointMake(0, 0);
    //创建画板为(400x400)pixels
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //将image原始图片(400x200)pixels缩放为(800x400)pixels
    CGContextConcatCTM(context, scaleTransform);
    //origin也会从原始(-100, 0)缩放到(-200, 0)
    [self drawAtPoint:origin];
    
    //获取缩放后剪切的image图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;

}




- (UIImage *)fixOrientation {
    

    if (self.imageOrientation == UIImageOrientationUp) return self;
 
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    

    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

 /** 上传图片 post参数*/
#pragma mark - 上传图片 转换 data
- (NSData *)uploadImgScaleImage
{
    UIImage *img = self;
    NSMutableDictionary *mDic = [img getUpLoadImageParmWithImage];
    NSString *filesize = mDic[@"filesize"];
    NSData *data1;
    data1 = UIImageJPEGRepresentation(img, 0.3);
    if ([filesize floatValue] > 2000000){
        img = [img scaleToSize:CGSizeMake(1000 , (img.size.height/img.size.width)*1000)];
        data1 = UIImageJPEGRepresentation(img, 0.3);
    }else{
        data1 = UIImageJPEGRepresentation(img, 1);
    }
    
    return data1;
}

- (NSMutableDictionary *)getUpLoadImageParmWithImage
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    int  perMBBytes = 1024*1024;
    
    CGImageRef cgimage = self.CGImage;
    size_t bpp = CGImageGetBitsPerPixel(cgimage);
    size_t bpc = CGImageGetBitsPerComponent(cgimage);
    size_t bytes_per_pixel = bpp / bpc;
    long lPixelsPerMB  = perMBBytes/bytes_per_pixel;
    long totalPixel = CGImageGetWidth(self.CGImage)*CGImageGetHeight(self.CGImage);
    long totalFileMB = (totalPixel/lPixelsPerMB)*perMBBytes;
    NSString *size = [NSString stringWithFormat:@"%ld",totalFileMB];
    
    [dic setObject:size forKey:@"filesize"];
    NSString *width = [NSString stringWithFormat:@"%f",self.size.width];
    [dic setObject:width forKey:@"width"];
    
    [dic setObject:@"temp.jpg" forKey:@"filename"];
    return dic;
}
//压缩图片到 ?k
-(UIImage *)scaleImageToKb:(NSInteger)kb
{
    
    kb*=1024;
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(self, compression);
    while ([imageData length] > kb && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(self, compression);
    }
    NSLog(@"当前大小:%fkb",(float)[imageData length]/1024.0f);
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;

}
@end
