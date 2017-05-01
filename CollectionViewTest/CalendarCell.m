//
//  CalendarCell.m
//  CollectionViewTest
//
//  Created by yuu ogasawara on 2017/05/01.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "CalendarCell.h"
#import "CalenderDataSource.h"

@interface CalendarCell ()
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (nonatomic) NSArray* days;

//@property (nonatomic) NSDate* firstDateOfMonth;

/**
 *  Selected date displayed by the calendar
 */
//@property (nonatomic, strong) NSDate *selectedDate;

@end

@implementation CalendarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
    self.days = @[@"日",@"月",@"火",@"水",@"木",@"金",@"土"];
    
    //FIXME: これはKVOなりで他のクラスと同期をとる
    //FIXME: 選ばれている月
    //self.selectedDate = [NSDate date];
}

+(NSString *)className{
    return NSStringFromClass([CalendarCell class]);
}

- (void)setCellFor:(NSIndexPath*)indexPath{
    //日曜日ならテキストの色は赤
    if (indexPath.row % 7 == 0) {
        self.dayLabel.textColor = [UIColor colorWithRed:1.0
                                                  green:0.0
                                                   blue:0.0
                                                  alpha:0.5];
    }
    
    //土曜日はテキストの色は青
    if (indexPath.row % 7 == 6) {
        self.dayLabel.textColor = [UIColor colorWithRed:0.0
                                                  green:0.0
                                                   blue:1.0
                                                  alpha:0.5];
    }
    
    switch (indexPath.section) {
        case 0:
            //セクション０なら、曜日を
            self.dayLabel.text = self.days[indexPath.row];
            break;
            
        case 1:{
            //セクション１なら、日を返す
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.dateFormat = @"d";
            self.dayLabel.text = [formatter stringFromDate:[self dateForCellAtIndexPath:indexPath]];
            
            break;
        }
        default:
            break;
    }
}


/**
 セルを再利用前に初期化する
 */
-(void)prepareForReuse{
    self.dayLabel.text = @"";
    self.dayLabel.textColor = [UIColor blackColor];
}

- (NSDate *)dateForCellAtIndexPath:(NSIndexPath *)indexPath
{
    // 「月の初日が週の何日目か」を計算する
    NSInteger ordinalityOfFirstDay =
    [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay
                                            inUnit:NSCalendarUnitWeekOfMonth
                                           forDate:[self firstDateOfMonth]];
    
    // 「月の初日」と「indexPath.item番目のセルに表示する日」の差を計算する
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.day = indexPath.item - (ordinalityOfFirstDay - 1);
    
    NSDate *date =
    [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents
                                                  toDate:self.firstDateOfMonth
                                                 options:0];
    return date;
}

/**
 *  Return First date of the month
 *
 *  @return date
 */
- (NSDate *)firstDateOfMonth
{
    NSDate *selectedDate = [CalenderDataSource sharedDataSource].selectedDate;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                                   fromDate:selectedDate];
    components.day = 1;
    
    NSDate *firstDateMonth = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    return firstDateMonth;
}

-(BOOL)judgeSelectedMonthInclude:(NSIndexPath*)indexPath{
    
    return YES;
}
@end
