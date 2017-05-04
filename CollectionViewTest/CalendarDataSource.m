//
//  CalenderDataSource.m
//  CollectionViewTest
//
//  Created by yuu ogasawara on 2017/05/01.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "CalendarDataSource.h"
#import "CalendarCell.h"
#import "NSDate+Extension.h"
#import "Const.h"

typedef NS_ENUM(NSUInteger, SectionName){
    date = 0,
    day
};

NSUInteger const DaysPerWeek = 7;

@interface CalendarDataSource()

@end

@implementation CalendarDataSource

#pragma mark initialize and singleton
static CalendarDataSource* _sharedInstance = nil;

+(CalendarDataSource *)sharedDataSource{
    if (!_sharedInstance){
        _sharedInstance = [[CalendarDataSource alloc] init];
    }
    
    return _sharedInstance;
}

-(id)init{
    self = [super init];
    
    self.days = @[@"日",@"月",@"火",@"水",@"木",@"金",@"土"];
    
    //FIXME: 選ばれている月
    self.selectedDate = [NSDate date];
    
    return self;
}

#pragma mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //曜日と日の2セクション
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section{
    //セクション０が曜日を表示、セクション１が日を表示
    switch (section) {
        case date:
            return self.days.count;
            break;
        case day:{
            // calculate number of weeks
//            NSCalendar* calendar = [NSCalendar currentCalendar];
//            NSDateComponents *components = [[NSDateComponents alloc] init];
//            components.year = self.selectedDate.year;
//            components.month = self.selectedDate.month;
//            NSDate *date = [calendar dateFromComponents:components];
//            NSRange rangeOfWeeks = [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth
//                                                                      inUnit:NSCalendarUnitMonth
//                                                                     forDate:date];
            
            NSUInteger numberOfWeeks = self.selectedDate.neededRowNumberForCalendar;
            NSInteger numberOfItems = numberOfWeeks * DaysPerWeek;
            NSLog(@"%zd / %zd numberOfItems:%zd",self.selectedDate.year,self.selectedDate.month,numberOfItems);
            return numberOfItems;
        }
            
        default:
            break;
    }
    
    return 30;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CalendarCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CalendarCell className]
                                                                   forIndexPath:indexPath];
    [cell setCellFor:indexPath];
    
    return cell;
}

+(void)makeSelectedDateAMonthPrevius{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDate* selectedDate = (NSDate*)[ud objectForKey:kSelectedDate];
    selectedDate = selectedDate.monthAgoDate;
    [ud setObject:selectedDate
           forKey:kSelectedDate];
    [ud synchronize];
}

+(void)makeSelectedDateAMonthFoward{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDate* selectedDate = (NSDate*)[ud objectForKey:kSelectedDate];
    selectedDate = selectedDate.monthLaterDate;
    [ud setObject:selectedDate
           forKey:kSelectedDate];
    [ud synchronize];
}

-(NSDate*)selectedDate{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return (NSDate*)[ud objectForKey:kSelectedDate];
}

-(void)setSelectedDate:(NSDate *)selectedDate{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:selectedDate
           forKey:kSelectedDate];
    [ud synchronize];
}
@end