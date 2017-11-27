//
//  JYCityListView.m
//  JYCashLoan
//
//  Created by Kim on 2017/11/8.
//  Copyright © 2017年 jieyue. All rights reserved.
//

#import "JYCityListView.h"
#import "NSString+PinYin.h"
#import "JYLocationManager.h"
#import "CMTitleAlertView.h"
#import "CMColor.h"
#import "FMDB.h"

#define kDeviceWidth           [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight          [UIScreen mainScreen].bounds.size.height
#define HRGB(a)      [UIColor colorWithRGBHexString:a]
#define BlueColor   HRGB(@"51BBFF")
#define GreyColor   HRGB(@"666666")
#define LiveProvinceCode @"LiveProvinceCode"
#define LiveCountyCode @"LiveCountyCode"
#define LiveCityCode @"LiveCityCode"


@interface JYCityListView()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *levelOneBtn;
@property (weak, nonatomic) IBOutlet UIButton *levelTwoBtn;
@property (weak, nonatomic) IBOutlet UIButton *levelThreeBtn;
@property (weak, nonatomic) IBOutlet UIView *sliderView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;
@property (strong, nonatomic) UITableView *levelOneTabel;  // 省
@property (strong, nonatomic) UITableView *levelTwoTabel;  // 市
@property (strong, nonatomic) UITableView *levelThreeTabel;// 县
@property (strong, nonatomic) NSMutableArray *arrProvince; // 省的数据源
@property (strong, nonatomic) NSMutableArray *dataSource;  // 总的的数据源
@property (strong, nonatomic) NSMutableArray *arrCity;     // 市的数据源
@property (strong, nonatomic) NSMutableArray *arrContry;   // 区的数据源
@property (strong, nonatomic) UILabel *fixedPositionLab; // 定位到的城市名称
@property (strong, nonatomic) NSString *cityName;        // 最终选择的城市
@property (strong, nonatomic) NSArray *currentCityArr;  // 当前选中的省Dic

@end

@implementation JYCityListView

- (NSMutableArray *)arrProvince {
    if (_arrProvince == nil) {
        _arrProvince = [NSMutableArray array];
    }
    return _arrProvince;
}
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (NSMutableArray *)arrCity {
    if (_arrCity == nil) {
        _arrCity = [NSMutableArray array];
    }
    return _arrCity;
}
- (NSMutableArray *)arrContry {
    if (_arrContry == nil) {
        _arrContry = [NSMutableArray array];
    }
    return _arrContry;
}

- (UITableView *)levelOneTabel {
    if (_levelOneTabel == nil) {
        _levelOneTabel = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _levelOneTabel.delegate = self;
        _levelOneTabel.dataSource = self;
        _levelOneTabel.separatorStyle = UITableViewCellSeparatorStyleNone;
        _levelOneTabel.showsHorizontalScrollIndicator = NO;
        _levelOneTabel.tag = 111;
        UIView *greyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 35)];
        greyView.backgroundColor = HRGB(@"EDEDED");
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 15, 15)];
        icon.image = [UIImage imageNamed:@"icon_app_position"];
        [greyView addSubview:icon];
        _fixedPositionLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, kDeviceWidth - 150, 15)];
        _fixedPositionLab.textColor = HRGB(@"666666");
        _fixedPositionLab.font = [UIFont systemFontOfSize:14];
        _fixedPositionLab.text = @"当前定位城市";
        [greyView addSubview:_fixedPositionLab];
        _levelOneTabel.tableHeaderView = greyView;
        _levelOneTabel.sectionIndexColor = [UIColor colorWithRed:0.10 green:0.68 blue:0.94 alpha:1.0];
        _levelOneTabel.sectionIndexBackgroundColor = [UIColor clearColor];
    }
    return _levelOneTabel;
}
- (UITableView *)levelTwoTabel {
    if (_levelTwoTabel == nil) {
        _levelTwoTabel = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _levelTwoTabel.delegate = self;
        _levelTwoTabel.dataSource = self;
        _levelTwoTabel.separatorStyle = UITableViewCellSeparatorStyleNone;
        _levelTwoTabel.showsHorizontalScrollIndicator = NO;
        _levelTwoTabel.tag = 222;
    }
    return _levelTwoTabel;
}
- (UITableView *)levelThreeTabel {
    if (_levelThreeTabel == nil) {
        _levelThreeTabel = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _levelThreeTabel.delegate = self;
        _levelThreeTabel.dataSource = self;
        _levelThreeTabel.separatorStyle = UITableViewCellSeparatorStyleNone;
        _levelThreeTabel.showsHorizontalScrollIndicator = NO;
        _levelThreeTabel.tag = 333;
    }
    return _levelThreeTabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 30)];
    view.backgroundColor = [UIColor redColor];
    [self.bgScrollView addSubview:view];
    [self.bgScrollView addSubview:self.levelOneTabel];
    [self.bgScrollView addSubview:self.levelTwoTabel];
    [self.bgScrollView addSubview:self.levelThreeTabel];
    
    CGFloat scrollViewH = self.bgScrollView.frame.size.height;
    self.bgScrollView.contentSize = CGSizeMake(kDeviceWidth*3, scrollViewH);
    self.bgScrollView.delegate = self;
    self.levelOneTabel.frame = CGRectMake(0, 0, kDeviceWidth, scrollViewH);
    self.levelTwoTabel.frame = CGRectMake(kDeviceWidth, 0, kDeviceWidth, scrollViewH);
    self.levelThreeTabel.frame = CGRectMake(kDeviceWidth*2, 0, kDeviceWidth, scrollViewH);
    // 读取城市数据
    [self getCityData];
}

- (void)getCityData {
    
    //所有的省的集合
    NSArray *provinceArray = [self getProvinceInfo];
    NSLog(@"%@", provinceArray);
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *plistPath = [bundle pathForResource:@"address" ofType:@"plist"];
//    NSDictionary*addressDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
//    NSArray *dataArray=[addressDic objectForKey:@"address"];
    // 赋值总数据源
    [self.dataSource addObjectsFromArray:provinceArray];
    // 提取出来所有的省
    NSMutableArray *priviceNames = [NSMutableArray array];
    for (NSDictionary *dic in provinceArray) {
        [priviceNames addObject:dic[@"areaname"]];
    }
    NSArray *indexArray= [priviceNames arrayWithPinYinFirstLetterFormat];
    self.arrProvince =[NSMutableArray arrayWithArray:indexArray];
    [self.levelOneTabel reloadData];
}
/// 定位当前城市
- (void)locationAction {
    __weak typeof(self) weakSelf = self;
    [[JYLocationManager sharedInstance] getLocationPlacemark:^(CLPlacemark *placemark) {
        if (placemark.locality) {
            weakSelf.fixedPositionLab.text = [NSString stringWithFormat:@"当前定位城市：%@%@",placemark.locality,placemark.subLocality];
            
        } else {
            weakSelf.fixedPositionLab.text = @"定位失败";
        }
    } status:^(CLAuthorizationStatus status) {
//        if (status != kCLAuthorizationStatusAuthorizedAlways && status != kCLAuthorizationStatusAuthorizedWhenInUse) {
        if (status == kCLAuthorizationStatusDenied) {
            if (weakSelf.alertBlock) {
                weakSelf.alertBlock();
            }
        } else {
            weakSelf.fixedPositionLab.text = @"定位中……";
        }
    } didFailWithError:^(NSError *error) {
        weakSelf.fixedPositionLab.text = @"定位失败";

    }];
}
/// 取消按钮点击
- (IBAction)cancelSelect:(id)sender {
    if (self.closeBlock != nil) {
        self.closeBlock(@"");
        [self reSetView];
    }
}
- (IBAction)clickLevelOneBtn:(id)sender {
    [self selectOne];
}
- (IBAction)clickLevelTwoBtn:(id)sender {
    [self selectTwo];
}
- (IBAction)clickLevelThreeBtn:(id)sender {
}


#pragma mark - UITabelViewDelegate, UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = HRGB(@"666666");
    }
    if (tableView.tag == 111) {
        NSDictionary *dict = self.arrProvince[indexPath.section];
        NSMutableArray *array = dict[@"content"];
        cell.textLabel.text = array[indexPath.row];
    } else if (tableView.tag == 222) {
        cell.textLabel.text = self.arrCity[indexPath.row];
    } else if (tableView.tag == 333) {
        cell.textLabel.text = self.arrContry[indexPath.row][@"areaname"];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 111) {
            NSDictionary *dict = self.arrProvince[section];
            NSMutableArray *array = dict[@"content"];
            return [array count];
    } else if (tableView.tag == 222) {
        return self.arrCity.count;
    } else if (tableView.tag == 333) {
        return self.arrContry.count;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 111) {
        return self.arrProvince.count;
    }
    return 1;
}
//添加索引栏标题数组
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray*resultArray = [[NSMutableArray alloc]init];
    if (tableView.tag == 111) {
        for (NSDictionary *dict in self.arrProvince) {
            NSString *title = dict[@"firstLetter"];
            [resultArray addObject:title];
        }
        return resultArray;
    }
    return nil;
}
//点击索引栏标题时执行
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 2.button的显示隐藏
    // 3.scrollView的偏移量
    // 4.滑块的偏移量
    if (tableView.tag == 111) {
        // 提取当前选中的省的市（因为a-z排序所以无序了）
        NSDictionary *dict = self.arrProvince[indexPath.section];
        NSMutableArray *array = dict[@"content"];
        NSString *provinceStr = array[indexPath.row];
        int currentIndex = 0;
        for (int i = 0 ; i < self.dataSource.count; i++) {
            NSDictionary *dic = self.dataSource[i];
            NSString *tmpStr = dic[@"areaname"];
            if ([tmpStr isEqualToString:provinceStr]) {
                currentIndex = i;
                break;
            }
        }
        // 更改市的数据源
       
        NSDictionary *provinceDic = self.dataSource[currentIndex];
         NSLog(@"%@", [self getCity:provinceDic[@"areaId"]]);
        [[NSUserDefaults standardUserDefaults] setObject:provinceDic[@"areaId"] forKey:LiveProvinceCode];
        
//        NSArray *cityDicArray = [provinceDic objectForKey:@"sub"];
        NSArray *cityDicArray = [self getCity:provinceDic[@"areaId"]];
        // tableThree的数据源赋值
        
#warning 此处取市的code
        self.currentCityArr = cityDicArray;
        // 提取出来所有的市
        NSMutableArray *cityNames = [NSMutableArray array];
        for (NSDictionary *dic in cityDicArray) {
            [cityNames addObject:dic[@"areaname"]];
        }
        [self.arrCity removeAllObjects];
        [self.arrCity addObjectsFromArray:cityNames];
        // 更改button标题&颜色
        [self.levelTwoBtn setHidden:false];
        [self.levelOneBtn setTitle:provinceStr forState:UIControlStateNormal];
        [self.levelOneBtn setTitleColor:GreyColor forState:UIControlStateNormal];
        [self.levelTwoBtn setTitleColor:BlueColor forState:UIControlStateNormal];
        // 市表格刷新数据
        [self.levelTwoTabel reloadData];
        [self.bgScrollView setContentOffset:CGPointMake(kDeviceWidth, 0) animated:NO];
        // 滑块滑动
        CGSize size = [provinceStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        [UIView animateWithDuration:0.25 animations:^{
            // 恢复初始大小
            CGRect sliderpreF = self.sliderView.frame;
            sliderpreF.size.width = 44;
            self.sliderView.frame = sliderpreF;
            CGPoint preCenter = self.sliderView.center;
            preCenter.x = size.width + 20 + 16 + 22;// 按钮根据文字自适应大小 + x坐标 + 间距 + 默认三个字一半的宽度
            self.sliderView.center = preCenter;
        }];
        
    } else if (tableView.tag == 222) {
        
        NSDictionary *countryDic = self.currentCityArr[indexPath.row];
         [[NSUserDefaults standardUserDefaults] setObject:countryDic[@"areaId"] forKey:LiveCityCode];
//        NSArray *contryArr = [countryDic objectForKey:@"sub"];
        NSArray *contryArr = [self getCity:countryDic[@"areaId"]];
        [self.arrContry removeAllObjects];
        [self.arrContry addObjectsFromArray:contryArr];
        [self.levelThreeTabel reloadData];
        [self.levelThreeBtn setHidden:false];
        [self.levelThreeBtn setTitleColor:BlueColor forState:UIControlStateNormal];
        NSString *countryStr = self.arrCity[indexPath.row];
        [self.levelTwoBtn setTitle:countryStr forState:UIControlStateNormal];
        [self.levelOneBtn setTitleColor:GreyColor forState:UIControlStateNormal];
        [self.levelTwoBtn setTitleColor:GreyColor forState:UIControlStateNormal];
        [self.bgScrollView setContentOffset:CGPointMake(kDeviceWidth*2, 0) animated:NO];
        CGSize size = [countryStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        
        [UIView animateWithDuration:0.25 animations:^{
            // 恢复初始大小
            CGRect sliderpreF = self.sliderView.frame;
            sliderpreF.size.width = 44;
            self.sliderView.frame = sliderpreF;
            CGPoint preCenter = self.sliderView.center;
            preCenter.x = CGRectGetMaxX(self.levelOneBtn.frame) + size.width + 20 + 13 + 22;// 按钮根据文字自适应大小 + x坐标 + 间距 + 默认三个字一半的宽度
            self.sliderView.center = preCenter;
        }];
    } else if (tableView.tag == 333) {
        NSString *addressStr = [NSString stringWithFormat:@"%@%@%@",self.levelOneBtn.currentTitle,self.levelTwoBtn.currentTitle,self.arrContry[indexPath.row][@"areaname"]];
        [[NSUserDefaults standardUserDefaults] setObject:self.arrContry[indexPath.row][@"areaId"] forKey:LiveCountyCode];
        self.cityName = addressStr;
        if (self.closeBlock != nil) {
            self.closeBlock(self.cityName);
            [self reSetView];
        }
    }
}

- (void)selectOne {
    [self.bgScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    CGRect levelBtnF = self.levelOneBtn.frame;
    levelBtnF.origin.y = 74;
    levelBtnF.size.height = 1.5;
    self.sliderView.frame = levelBtnF;
    [self.levelOneBtn setTitleColor:BlueColor forState:UIControlStateNormal];
    [self.levelTwoBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [self.levelTwoBtn setTitleColor:GreyColor forState:UIControlStateNormal];
    [self.levelTwoBtn setHidden:YES];
    [self.levelThreeBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [self.levelThreeBtn setTitleColor:GreyColor forState:UIControlStateNormal];
    [self.levelThreeBtn setHidden:YES];
}
- (void)selectTwo {
    [self.bgScrollView setContentOffset:CGPointMake(kDeviceWidth, 0) animated:NO];
    CGRect levelBtnF = self.levelTwoBtn.frame;
    levelBtnF.origin.y = 74;
    levelBtnF.size.height = 1.5;
    self.sliderView.frame = levelBtnF;
    [self.levelTwoBtn setTitleColor:BlueColor forState:UIControlStateNormal];
    [self.levelThreeBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [self.levelThreeBtn setHidden:YES];
    
}

// 重置页面数据
- (void)reSetView {
    self.bgScrollView.contentOffset = CGPointMake(0, 0);
    [self.levelTwoBtn setHidden:YES];
    [self.levelThreeBtn setHidden:YES];
    [self.levelOneBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [self.levelTwoBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [self.levelThreeBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [self.levelOneBtn setTitleColor:BlueColor forState:UIControlStateNormal];
    self.sliderView.frame = CGRectMake(20, 74, 44, 1.5);
    [self.levelOneTabel reloadData];
    [self.levelOneTabel setContentOffset:CGPointMake(0, 0) animated:NO];
    
}


-(NSArray*)getCity:(NSString*)strParentId
{
    NSMutableArray *arrInfo;
    FMDatabase *db = [FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"sqlite"]];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return nil;
    }
    
    if (arrInfo != nil)
    {
        [arrInfo removeAllObjects];
        arrInfo = nil;
    }
    arrInfo = [[NSMutableArray alloc] init];
    
    FMResultSet *resultParentId = [db executeQuery:@"select * from area where parentId = ?",strParentId];
    
    while ([resultParentId next])
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             [resultParentId stringForColumn:@"areaname"],@"areaname",
                             [resultParentId stringForColumn:@"id"],@"areaId", nil];
        [arrInfo addObject:dic];
    }
    
    [db close];
    
    return arrInfo;
}


- (NSArray*)getProvinceInfo {
    NSMutableArray *arrInfo;
    FMDatabase *db = [FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"sqlite"]];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return nil;
    }
    
    if (arrInfo != nil)
    {
        [arrInfo removeAllObjects];
        arrInfo = nil;
    }
    arrInfo = [[NSMutableArray alloc] init];
    FMResultSet *resultParentId = [db executeQuery:@"select * from area where parentId = 0 order by id"];
    
    while ([resultParentId next])
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             [resultParentId stringForColumn:@"areaname"],@"areaname",
                             [resultParentId stringForColumn:@"id"],@"areaId", nil];
        [arrInfo addObject:dic];
    }
    
    [db close];
    
    return arrInfo;
}


@end
