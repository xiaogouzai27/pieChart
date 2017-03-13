//
//  ViewController.m
//  pieChar
//
//  Created by everp2p on 17/3/13.
//  Copyright © 2017年 TangLiHua. All rights reserved.
//

#define kDeviceWidth                [UIScreen mainScreen].bounds.size.width      // 界面宽度
#define kDeviceHeight               [UIScreen mainScreen].bounds.size.height     // 界面高度

// 屏幕比例适配(以iPhone6为基准设计)
#define KScale                      kDeviceWidth / 375 //比例系数

#import "ViewController.h"
#import "AssetsViewController.h"
#import "TotalAmountViewController.h"
#import "ZFChart.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource ,ZFPieChartDataSource, ZFPieChartDelegate>

@property(nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZFPieChart * pieChart;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) NSString *totalAmountMoney;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTableView];
    
//    _totalAmountMoney = @"0.00";
    
    _dataSource = @[@(20.9), @(36.5), @(72.6)];
    
//    AssetsViewController *vc1 = [[AssetsViewController alloc] init];
//    TotalAmountViewController *vc2 = [[TotalAmountViewController alloc] init];
//    NSArray *controllers = @[vc1,vc2];
//    NSArray *titleArray = @[@"资产总额",@"累计收益"];
    
}


-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 * KScale, kDeviceWidth, kDeviceHeight - 64 * KScale - 40 * KScale) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    
    
}
//行间距
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 40 * KScale;
}
//组间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 260;
    }else
        return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10.f;
    }else
        return 0.1f;
}

//组数
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else
        return 4;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    if (cell == nil) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"可用金额";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"冻结金额";
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"待收本金";
        }
        
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text = @"其它金额";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"累计投资";
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"累计提现";
        }else if (indexPath.row == 3){
            cell.textLabel.text = @"累计充值";
        }
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 260 * KScale)];
        headerView.backgroundColor = [UIColor whiteColor];
        
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 260 * KScale, kDeviceWidth, 1 * KScale)];
        lineLabel.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:lineLabel];
        
        self.pieChart = [[ZFPieChart alloc] initWithFrame:CGRectMake(87.5 * KScale, 30 * KScale, 200 * KScale, 200 * KScale)];
        self.pieChart.dataSource = self;
        self.pieChart.delegate = self;
        self.pieChart.isShadow = NO;
        self.pieChart.isAnimated = YES;
        self.pieChart.isShowPercent = NO;
        [self.pieChart strokePath];
        
        [headerView addSubview:self.pieChart];
        
        return headerView;
    }else
        return nil;
}



#pragma mark - ZFPieChartDataSource

- (NSArray *)valueArrayInPieChart:(ZFPieChart *)chart
{
    if ([_totalAmountMoney isEqualToString:@"0.00"]) {
        return @[@"1"];
    }
    return _dataSource;
    
}

- (NSArray *)colorArrayInPieChart:(ZFPieChart *)chart
{
    if ([_totalAmountMoney isEqualToString:@"0.00"]) {
        return @[[UIColor grayColor]];
    }
    return @[[UIColor redColor], [UIColor blueColor],[UIColor greenColor]];
}

#pragma mark - ZFPieChartDelegate

- (void)pieChart:(ZFPieChart *)pieChart didSelectPathAtIndex:(NSInteger)index
{
    NSLog(@"第%ld个",(long)index);
}

- (CGFloat)radiusForPieChart:(ZFPieChart *)pieChart{
    return 100.f;
}

/** 此方法只对圆环类型(kPieChartPatternTypeForCirque)有效 */
- (CGFloat)radiusAverageNumberOfSegments:(ZFPieChart *)pieChart{
    return 2.5f;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
