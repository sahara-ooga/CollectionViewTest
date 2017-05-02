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
    NSCalendar* calender = [NSCalendar currentCalendar];
    NSInteger month = [calender component:NSCalendarUnitMonth
                                  fromDate:self];
    NSInteger referenceMonth = [calender component:NSCalendarUnitMonth
                                          fromDate:referenceDate];
    
    return month == referenceMonth;
}
@end
