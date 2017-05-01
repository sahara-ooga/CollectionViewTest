//
//  CalenderDataSource.h
//  CollectionViewTest
//
//  Created by yuu ogasawara on 2017/05/01.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface CalenderDataSource : NSObject<UICollectionViewDataSource>

@property (nonatomic) NSArray *days;

/**
 *  Selected date displayed by the calendar
 */
@property (nonatomic, strong) NSDate *selectedDate;
+(CalenderDataSource*)sharedDataSource;
@end
