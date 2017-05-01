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
#import "CalenderDelegateFlowLayout.h"
#import "NSDate+Extension.h"

@interface CalenderViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) CalenderDataSource* calenderDataSource;
@property (nonatomic) CalenderDelegateFlowLayout* calenderDelegateFlowLayout;
/**
 *  Selected date displayed by the calendar
 */
//@property (nonatomic, strong) NSDate *selectedDate;

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
    
    self.calenderDelegateFlowLayout = [[CalenderDelegateFlowLayout alloc] init];
    self.collectionView.delegate = self.calenderDelegateFlowLayout;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // set up toolbar
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)];
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

- (void)didTapPrevButton:(id)sender
{
    [CalenderDataSource sharedDataSource].selectedDate = [[CalenderDataSource sharedDataSource].selectedDate monthAgoDate];
    
    [self.collectionView reloadData];
}

- (void)didTapNextButton:(id)sender
{
    [CalenderDataSource sharedDataSource].selectedDate = [[CalenderDataSource sharedDataSource].selectedDate monthLaterDate];
    
    [self.collectionView reloadData];
}

#pragma mark - private methods

- (void)setSelectedDate:(NSDate *)selectedDate
{
    [CalenderDataSource sharedDataSource].selectedDate = selectedDate;
    
    // update title text
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy年M月";
    self.navigationItem.title = [formatter stringFromDate:selectedDate];
}


@end
