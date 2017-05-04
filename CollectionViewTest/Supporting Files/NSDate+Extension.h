//
//  NSDate+Extension.h
//  CollectionViewTest
//
//  Created by yuu ogasawara on 2017/05/01.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
- (NSDate *)monthAgoDate;
- (NSDate *)monthLaterDate;
- (NSDate *)firstDateOfMonth;
- (BOOL)isContainedInMonthOf:(NSDate*)referenceDate;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger year;
@property (readonly) NSInteger weekDay;
@property (readonly) NSInteger daysOfMonth;
@property (readonly) NSInteger neededRowNumberForCalendar;
@property (readonly) NSString *titleFormattedString;
@end
