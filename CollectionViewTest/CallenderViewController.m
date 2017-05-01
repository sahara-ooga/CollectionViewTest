//
//  ViewController.m
//  CollectionViewTest
//
//  Created by yuu ogasawara on 2017/05/01.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "CallenderViewController.h"

@interface CallenderViewController ()<UICollectionViewDelegateFlowLayout>

@end

@implementation CallenderViewController
-(void)awakeFromNib{
    [super awakeFromNib];
    self.days = @[@"日",@"月",@"火",@"水",@"木",@"金",@"土"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
