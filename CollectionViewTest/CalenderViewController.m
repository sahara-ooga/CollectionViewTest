//
//  CalenderViewController.m
//  CollectionViewTest
//
//  Created by yuu ogasawara on 2017/05/01.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "CalenderViewController.h"
#import "CalendarCell.h"
#import "CalenderDataSource.h"

@interface CalenderViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) CalenderDataSource* calenderDataSource;

/**
 *  Selected date displayed by the calendar
 */
@property (nonatomic, strong) NSDate *selectedDate;

@end

@implementation CalenderViewController
@synthesize collectionView;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerNib:[UINib nibWithNibName:[CalendarCell className]
                                                    bundle:nil]
          forCellWithReuseIdentifier:[CalendarCell className]];
    
    self.calenderDataSource = [[CalenderDataSource alloc] init];
    self.collectionView.dataSource = self.calenderDataSource;
    
    self.selectedDate = [NSDate date];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action methods

//- (IBAction)didTapPrevButton:(id)sender
//{
//    self.selectedDate = [self.selectedDate monthAgoDate];
//    
//    [self.collectionView reloadData];
//}
//
//- (IBAction)didTapNextButton:(id)sender
//{
//    self.selectedDate = [self.selectedDate monthLaterDate];
//    
//    [self.collectionView reloadData];
//}

#pragma mark - private methods

//- (void)setSelectedDate:(NSDate *)selectedDate
//{
//    _selectedDate = selectedDate;
//    
//    // update title text
//    NSDateFormatter *formatter = [NSDateFormatter new];
//    formatter.dateFormat = @"yyyy/M";
//    self.title = [formatter stringFromDate:selectedDate];
//}


@end
