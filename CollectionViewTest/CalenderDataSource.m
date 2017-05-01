//
//  CalenderDataSource.m
//  CollectionViewTest
//
//  Created by yuu ogasawara on 2017/05/01.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "CalenderDataSource.h"
#import "CalendarCell.h"

@implementation CalenderDataSource
-(id)init{
    self = [super init];
    
    self.days = @[@"日",@"月",@"火",@"水",@"木",@"金",@"土"];
    return self;
}

#pragma mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //曜日と日の2セクション
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return self.days.count;
            break;
        case 1:
            //FIXME　その月の日数に変更
            return 31;
        default:
            break;
    }
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CalendarCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CalendarCell className]
                                                                   forIndexPath:indexPath];
    [cell setCellFor:indexPath];
    
    return cell;
}

@end
