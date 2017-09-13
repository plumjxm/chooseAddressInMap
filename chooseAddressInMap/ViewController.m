//
//  ViewController.m
//  chooseAddressInMap
//
//  Created by plum on 17/9/13.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "ViewController.h"

#import "MPFindNearAddressVC.h"
@interface ViewController ()
@property (weak,nonatomic) UILabel *addressLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIFont *titleFont = SystemFont(16);
    
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarBtn.backgroundColor = GREENColor;
    rightBarBtn.frame = CGRectMake((ScreenWidth - 100)/2, 100,100, 50);
    [rightBarBtn setTitleColor:[UIColor blackColor] forState:0];
    [rightBarBtn setTitle:@"选择位置" forState:0];
    rightBarBtn.titleLabel.font = titleFont;
    [rightBarBtn addTarget:self action:@selector(initChooseAddress) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:rightBarBtn];
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, rightBarBtn.bottom+20, ScreenWidth - 40, 0)];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:16];
    contentLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:contentLabel];
    self.addressLabel = contentLabel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initChooseAddress
{
    MPFindNearAddressVC *vc = [MPFindNearAddressVC new];
    [vc setReturnBlock:^(NSString *city,NSString *name,NSString *address,CGFloat latitude,CGFloat longitude,NSString *phone,UIImage *img){
        if (name) {
            
            _addressLabel.width = ScreenWidth - 40;
            _addressLabel.text = [NSString stringWithFormat:@"longitude = %.10f\nlatitude = %.10f\n%@",longitude,latitude,name];
            [_addressLabel sizeToFit];

        }
        
    }];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}


@end
