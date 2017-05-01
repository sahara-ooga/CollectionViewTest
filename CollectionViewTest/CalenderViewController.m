//
//  CalenderViewController.m
//  CollectionViewTest
//
//  Created by yuu ogasawara on 2017/05/01.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "CalenderViewController.h"
#import "CalendarCell.h"
#import "CalenderDataSource.h"

@interface CalenderViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) CalenderDataSource* calenderDataSource;
@end

@implementation CalenderViewController
@synthesize collectionView;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerNib:[UINib nibWithNibName:[CalendarCell className]
                                                    bundle:nil]
          forCellWithReuseIdentifier:[CalendarCell className]];
    
    self.calenderDataSource = [[CalenderDataSource alloc] init];
    self.collectionView.dataSource = self.calenderDataSource;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
