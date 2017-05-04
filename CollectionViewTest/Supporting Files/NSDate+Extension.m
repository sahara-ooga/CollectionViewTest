//
//  NSDate+Extension.m
//  CollectionViewTest
//
//  Created by yuu ogasawara on 2017/05/01.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
/**
 *  Return the date one month before the receiver.
 *
 *  @return  date
 */
- (NSDate *)monthAgoDate
{
    NSInteger addValue = -1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = addValue;
    return [calendar dateByAddingComponents:dateComponents
                                     toDate:self
                                    options:0];
}

/**
 *  Return the date one month after the receiver.
 *
 *  @return  date
 */
- (NSDate *)monthLaterDate
{
    NSInteger addValue = 1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = addValue;
    return [calendar dateByAddingComponents:dateComponents
                                     toDate:self
                                    options:0];
}

/**
 *  Return First date of the month
 *
 *  @return date
 */
- (NSDate *)firstDateOfMonth
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                                   fromDate:self];
    components.day = 1;
    
    NSDate *firstDateMonth = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    return firstDateMonth;
}

- (BOOL)isContainedInMonthOf:(NSDate*)referenceDate{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSInteger month = [calendar component:NSCalendarUnitMonth
                                  fromDate:self];
    NSInteger referenceMonth = [calendar component:NSCalendarUnitMonth
                                          fromDate:referenceDate];
    
    return month == referenceMonth;
}

/**
 http://biz.hino-tama.com/wp-content/uploads/2013/10/calendar_rows.gifから作成

 @return 自身が含まれる月をカレンダーで表示する際に必要な行数
 */
- (NSInteger)neededRowNumberForCalendar
{
    NSDate* firstDate = [self firstDateOfMonth];
    
    //1日が土曜日の場合、2月なら5行必要.2月でなければ6行必要
    if (firstDate.weekDay == 7) {
        if (firstDate.month == 2) {
            return 5;
        }else{
            return 6;
        }
    }
    
    //1日が金曜日なら、31日ある月なら6行必要、それ以外は5行必要
    if (firstDate.weekDay == 6) {
        if (self.daysOfMonth == 31) {
            return 6;
        }else{
            return 5;
        }
    }
    
    //「1日が日曜で2月」でないなら５行
    //　言い換えると
    //「１日が日曜でない」または「２月でない」なら５行
    if ((firstDate.weekDay != 1) || (self.month != 2)){
        return 5;
    }
    
    //「1日が日曜で2月」でかつうるう年なら５行
    if (firstDate.weekDay == 1 && self.month == 2 && self.daysOfMonth == 29) {
        return 5;
    }
    
    // 上記以外４行
    return 4;
}

-(NSInteger)day
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    return [calendar component:NSCalendarUnitDay
                      fromDate:self];
}

- (NSInteger)month
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    return [calendar component:NSCalendarUnitMonth
                      fromDate:self];
}

- (NSInteger)year
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    return [calendar component:NSCalendarUnitYear
                      fromDate:self];
}

/**
 グレゴリオ暦の場合、１が日曜日

 @return １からN（NSCalendarUnitWeekdayのレファレンス参照のこと）
 */
- (NSInteger)weekDay
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    return [calendar component:NSCalendarUnitWeekday fromDate:self];
}

/**
 <#Description#>

 @return 日が含まれる月の日数
 */
- (NSInteger)daysOfMonth
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    return [calendar rangeOfUnit:NSCalendarUnitDay
                          inUnit:NSCalendarUnitMonth
                         forDate:self].length;
}

-(NSString*)titleFormattedString{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy年M月";
    return [formatter stringFromDate:self];
}
@end
