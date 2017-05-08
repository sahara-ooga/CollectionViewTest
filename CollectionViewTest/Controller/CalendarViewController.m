//
//  CalenderViewController.m
//  CollectionViewTest
//
//  Created by yuu ogasawara on 2017/05/01.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarCell.h"
#import "CalendarDataSource.h"
#import "CalendarDelegateFlowLayout.h"
#import "NSDate+Extension.h"

@interface CalendarViewController ()
@property (nonatomic) CalendarDataSource* calenderDataSource;
@property (nonatomic) CalendarDelegateFlowLayout* calenderDelegateFlowLayout;
@end

@implementation CalendarViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerNib:[UINib nibWithNibName:[CalendarCell className]
                                                    bundle:nil]
          forCellWithReuseIdentifier:[CalendarCell className]];
    
    self.calenderDataSource = [CalendarDataSource sharedDataSource];
    self.collectionView.dataSource = self.calenderDataSource;
    
    self.calenderDelegateFlowLayout = [[CalendarDelegateFlowLayout alloc] init];
    self.collectionView.delegate = self.calenderDelegateFlowLayout;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // set up toolbar
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,
                                                                     self.view.bounds.size.height-44,
                                                                     self.view.bounds.size.width, 44)];
    
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    toolbar.backgroundColor = [UIColor blackColor];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"前へ"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(didTapPrevButton:)];
    
    UIBarButtonItem *forwardButton = [[UIBarButtonItem alloc] initWithTitle:@"次へ"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(didTapNextButton:)];
    
    UIBarButtonItem *buttonGap = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil
                                                                               action:nil];
    toolbar.items = @[backButton,buttonGap,forwardButton];
    
    [self.view addSubview:toolbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action methods

/**
 「前へ」ボタンが押されたら実行される

 @param sender ツールバー左下の「前へ」ボタン
 */
- (void)didTapPrevButton:(id)sender
{
    [CalendarDataSource makeSelectedDateAMonthPrevius];
    CalendarDataSource* dataSource = [CalendarDataSource sharedDataSource];
    [self.collectionView reloadData];
    [self setTitleToSelectedDate:dataSource.selectedDate];
}

- (void)didTapNextButton:(id)sender
{
    [CalendarDataSource makeSelectedDateAMonthFoward];
    CalendarDataSource* dataSource = [CalendarDataSource sharedDataSource];
    [self.collectionView reloadData];
    [self setTitleToSelectedDate:dataSource.selectedDate];
}

#pragma mark - private methods

/**
 update title text

 @param selectedDate タイトルに反映したいNSDate
 */
- (void)setTitleToSelectedDate:(NSDate *)selectedDate
{
    // update title text
    self.navigationItem.title = selectedDate.titleFormattedString;
}
@end
