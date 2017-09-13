//
//  MPNoResultHeadView.m
//  Vago
//
//  Created by Plum on 16/1/9.
//  Copyright © 2016年 ManPao. All rights reserved.
//

#import "MPNoResultHeadView.h"

@implementation MPNoResultHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self commonInit];
    }
    
    return self;
}
- (void)commonInit
{
    CGFloat left = 10;
    CGFloat HEIGH = self.height;

    CGFloat imgW = 15;
    CGFloat imgL = ScreenWidth - left - imgW;
    CGFloat imgT = (HEIGH - imgW)/2;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(left, 0, imgL -left*2, HEIGH)];
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:15];
    //label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor lightGrayColor];
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:label];
    self.textLabel = label;
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(imgL, imgT, imgW, imgW)];
    imgView.image = [UIImage imageNamed:@"箭头"];
    [self addSubview:imgView];

    
    UIImageView *line  = [[UIImageView alloc]initWithFrame:CGRectMake(0, HEIGH-LINEH, ScreenWidth, LINEH)];
    line.backgroundColor = LINECOLOR;
    [self addSubview:line];

}
- (void)setTextStr:(NSString *)textStr
{
    _textStr = textStr;
    
    self.textLabel.text = textStr;
}
@end
