//
//  CalenderDataSource.m
//  CollectionViewTest
//
//  Created by yuu ogasawara on 2017/05/01.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "CalenderDataSource.h"
#import "CalendarCell.h"

typedef NS_ENUM(NSUInteger, SectionName){
    date = 0,
    day
};

NSUInteger const DaysPerWeek = 7;

@interface CalenderDataSource()

//@property (nonatomic) NSDate* firstDateOfMonth;

/**
 *  Selected date displayed by the calendar
 */
@property (nonatomic, strong) NSDate *selectedDate;

@end

@implementation CalenderDataSource
//@synthesize firstDateOfMonth;

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
            //FIXME　その月の日数に変更
            // calculate number of weeks
            NSRange rangeOfWeeks = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth
                                                                      inUnit:NSCalendarUnitMonth
                                                                     forDate:[self firstDateOfMonth]];
            NSUInteger numberOfWeeks = rangeOfWeeks.length;
            NSInteger numberOfItems = numberOfWeeks * DaysPerWeek;
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

/*
*  Return First date of the month
*
*  @return date
*/
- (NSDate *)firstDateOfMonth
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                                   fromDate:self.selectedDate];
    components.day = 1;
    
    NSDate *firstDateMonth = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    return firstDateMonth;
}

@end
