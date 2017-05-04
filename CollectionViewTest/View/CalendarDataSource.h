//
//  CalenderDataSource.h
//  CollectionViewTest
//
//  Created by yuu ogasawara on 2017/05/01.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

//extern NSUInteger const DaysPerWeek;

@interface CalendarDataSource : NSObject<UICollectionViewDataSource>

@property (nonatomic) NSArray<NSString*> *days;

/**
 *  Selected date displayed by the calendar
 */
@property (nonatomic, strong) NSDate *selectedDate;
+(CalendarDataSource*)sharedDataSource;
+(void)makeSelectedDateAMonthPrevius;
+(void)makeSelectedDateAMonthFoward;
@end
