//
//  CollectionViewTestTests.m
//  CollectionViewTestTests
//
//  Created by yuu ogasawara on 2017/05/01.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+Extension.h"
#import "CalendarDataSource.h"
#import "CalendarViewController.h"

@interface CollectionViewTestTests : XCTestCase

@end

@implementation CollectionViewTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testYearMonthDay{
    //2017年５月３日でNSDate型を作成
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 2017;
    components.month = 5;
    components.day = 3;
    NSDate* date = [calender dateFromComponents:components];
    
    XCTAssertEqual(date.year, 2017);
    XCTAssertEqual(date.month, 5);
    XCTAssertEqual(date.day, 3);
}

-(void)testWeekDay{
    //2017年５月３日でNSDate型を作成
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 2017;
    components.month = 5;
    components.day = 3;
    NSDate* date = [calender dateFromComponents:components];
    
    XCTAssertEqual(date.weekDay, 4);
}

-(void)testDaysOfMonth{
    //2017年５月３日でNSDate型を作成
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 2017;
    components.month = 5;
    components.day = 3;
    NSDate* date = [calender dateFromComponents:components];

    XCTAssertEqual(date.daysOfMonth, 31);
    
    components.year = 2020;
    components.month = 2;
    components.day = 3;
    date = [calender dateFromComponents:components];
    XCTAssertEqual(date.daysOfMonth, 29);
}

-(void)testFirstDateOfMonth{
    //2017年５月３日でNSDate型を作成
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 2017;
    components.month = 5;
    components.day = 3;
    NSDate* date = [calender dateFromComponents:components];
    
    XCTAssertEqual(date.firstDateOfMonth.year, 2017);
    XCTAssertEqual(date.firstDateOfMonth.month, 5);
    XCTAssertEqual(date.firstDateOfMonth.day, 1);
}

-(void)testIsContainedInMonth{
    //2017年５月３日でNSDate型を作成
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 2017;
    components.month = 5;
    components.day = 3;
    NSDate* date = [calender dateFromComponents:components];

    NSDate* firstDay = date.firstDateOfMonth;
    XCTAssertTrue([date isContainedInMonthOf:firstDay]);
}

-(void)testMonthAgo{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 2017;
    components.month = 4;
    components.day = 2;
    NSDate* date = [calender dateFromComponents:components];
    XCTAssertEqual(date.monthAgoDate.year, 2017);
    XCTAssertEqual(date.monthAgoDate.month, 3);
    XCTAssertEqual(date.monthAgoDate.day, 2);
}

-(void)testMonthLater{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 2017;
    components.month = 4;
    components.day = 2;
    NSDate* date = [calender dateFromComponents:components];
    XCTAssertEqual(date.monthLaterDate.year, 2017);
    XCTAssertEqual(date.monthLaterDate.month, 5);
    XCTAssertEqual(date.monthLaterDate.day, 2);
}

-(void)testNeededRowNumber{
    //2017年4月(１日が土曜日３１日まであるケース）でNSDate型を作成
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 2017;
    components.month = 4;
    NSDate* date = [calender dateFromComponents:components];
    XCTAssertEqual(date.neededRowNumberForCalendar, 6);
    
    //正しく表示できなかった場合
    components.year = 2017;
    components.month = 7;
    date = [calender dateFromComponents:components];
    XCTAssertEqual(date.neededRowNumberForCalendar, 6);
    
    components.year = 2017;
    components.month = 12;
    date = [calender dateFromComponents:components];
    XCTAssertEqual(date.neededRowNumberForCalendar, 6);
    
    
    components.year = 2014;
    components.month = 2;
    date = [calender dateFromComponents:components];
    XCTAssertEqual(date.neededRowNumberForCalendar, 5);
    
    components.year = 2017;
    components.month = 9;
    date = [calender dateFromComponents:components];
    XCTAssertEqual(date.neededRowNumberForCalendar, 5);
    
    //「１日が日曜でない」または「２月でない」なら５行
    components.year = 2017;
    components.month = 11;
    date = [calender dateFromComponents:components];
    XCTAssertNotEqual(date.weekDay,1);
    XCTAssertEqual(date.neededRowNumberForCalendar, 5);
    
    //「1日が日曜で2月」でかつうるう年なら５行
    components.year = 2004;
    components.month = 2;
    date = [calender dateFromComponents:components];
    XCTAssertEqual(date.weekDay,1);
    XCTAssertEqual(date.daysOfMonth, 29);
    XCTAssertEqual(date.neededRowNumberForCalendar, 5);
    
    // 上記以外４行
    //例えば、「1日が日曜日で、2月」かつ「うるう年でない」
    components.year = 2015;
    components.month = 2;
    date = [calender dateFromComponents:components];
    XCTAssertEqual(date.weekDay,1);
    XCTAssertNotEqual(date.daysOfMonth, 29);
    XCTAssertEqual(date.neededRowNumberForCalendar, 4);
}

-(void)testRowNumber{
    //2017年4月(１日が土曜日３１日まであるケース）でNSDate型を作成
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 2017;
    components.month = 4;
    NSDate* date = [calender dateFromComponents:components];
    
    CalendarDataSource *dataSource = [[CalendarDataSource alloc] init];
    dataSource.selectedDate = date;
    
    
    UICollectionView* cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)
                                              collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    NSInteger rowNum = [dataSource collectionView:cv
                           numberOfItemsInSection:1];
    XCTAssertEqual(rowNum, 6*7);
}
@end
