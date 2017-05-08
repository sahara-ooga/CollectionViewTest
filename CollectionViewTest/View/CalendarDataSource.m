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

static NSInteger const kNumberOfSection = 2;
static NSInteger const kDefaultNumberOfDaysInMonth = 30;

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
    
    //曜日の配列
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.locale = [NSLocale localeWithLocaleIdentifier:@"ja_JP"];
    self.days = [calendar shortStandaloneWeekdaySymbols];
    
    //選ばれている月
    self.selectedDate = [NSDate date];
    
    return self;
}

#pragma mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //曜日と日の2セクション
    return kNumberOfSection;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section{
    //セクション０が曜日を表示、セクション１が日を表示
    switch (section) {
        case weekDay:
            return self.days.count;
            
        case day:{
            // calculate number of weeks            
            NSUInteger numberOfWeeks = self.selectedDate.neededRowNumberForCalendar;
            NSInteger numberOfItems = numberOfWeeks * DaysPerWeek;
            return numberOfItems;
        }
            
        default:
            return kDefaultNumberOfDaysInMonth;
    }
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
