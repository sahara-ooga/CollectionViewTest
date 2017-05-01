//
//  CalendarCell.m
//  CollectionViewTest
//
//  Created by yuu ogasawara on 2017/05/01.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "CalendarCell.h"
@interface CalendarCell ()
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (nonatomic) NSArray* days;

@end

@implementation CalendarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.days = @[@"日",@"月",@"火",@"水",@"木",@"金",@"土"];
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
            //TODO:日は赤、土は青
            self.dayLabel.text = self.days[indexPath.row];
            break;
            
            case 1:
            //セクション１なら、日を返す
            //TODO:日は赤、土は青
            self.dayLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row + 1];
            break;
            
        default:
            break;
    }
    
    
    
}

@end
