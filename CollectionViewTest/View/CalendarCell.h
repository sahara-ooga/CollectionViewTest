//
//  CalendarCell.h
//  CollectionViewTest
//
//  Created by yuu ogasawara on 2017/05/01.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarCell : UICollectionViewCell
+ (NSString*)className;
- (void)setCellFor:(NSIndexPath*)indexPath;
@end
