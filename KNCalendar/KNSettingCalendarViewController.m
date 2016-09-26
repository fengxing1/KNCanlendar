//
//  KNSettingCalendarViewController.m
//  KNCalendar
//
//  Created by zhukeshuai on 16/4/9.
//  Copyright © 2016年 maihaoche. All rights reserved.
//

#import "KNSettingCalendarViewController.h"
#import "NSDate+WQCalendarLogic.h"
#import "KNDateChooseModel.h"

@interface KNSettingCalendarViewController ()<UITextFieldDelegate,SimulateActionSheetDelegate>
@property (nonatomic, strong) KNDateChooseModel *dateChooseModel;
@property (weak, nonatomic) IBOutlet UIView *backgroupView;
@end

@implementation KNSettingCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 初始化一个返回按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    // 为返回按钮设置图片样式
    [button setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    // 设置返回按钮触发的事件
    [button addTarget:self action:@selector(naviClickBack) forControlEvents:UIControlEventTouchUpInside];
    // 初始化一个BarButtonItem，并将其设置为返回的按钮的样式
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    negativeSpacer.width = -15;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, backButton, nil];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(commitDate)];
    rightButtonItem.tintColor = [UIColor colorWithRed:66/255 green:66/255 blue:66/255 alpha:1];
    self.navigationItem.rightBarButtonItem = rightButtonItem;

}
- (void)setupView
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboardAndCanlender)];
    [self.backview addGestureRecognizer:tap];
    self.workDays.returnKeyType = UIReturnKeyDone;
    self.restDays.returnKeyType = UIReturnKeyDone;
    self.workDays.keyboardType = UIKeyboardTypeNumberPad;
    self.restDays.keyboardType = UIKeyboardTypeNumberPad;
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"ChosedDate"];
    self.dateChooseModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (self.dateChooseModel == nil) {
        self.dateChooseModel = [[KNDateChooseModel alloc] init];
        self.dateChooseModel.workDays = 4;
        self.dateChooseModel.restDays = 2;
        self.dateChooseModel.firstWorkDay = [NSDate date];
    }
//    NSDate *  senddate=[NSDate date];
//    
//    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    
//    [dateformatter setDateFormat:@"YYYYMMdd"];
//    
//    NSString *locationString=[dateformatter stringFromDate:senddate];
//    self.chooseFirstDay.placeholder = locationString;
//    
//    _datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0.0,0.0,0.0,0.0)];
//    _datePicker.datePickerMode = UIDatePickerModeDate;
//    
//    NSDate *currentDate = [NSDate date];
//    
//    NSDate *beforeDate = [currentDate dayInTheFollowingDay:-60];
//    NSDate *afterDate = [currentDate dayInTheFollowingDay:60];
    
    [self changeDateValue:self.dateChooseModel];
    self.chooseFirstDay.delegate = self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self hiddenKeyboard];
    self.sheet = [MHCB2BActionSheet styleDefault];
//    __weak typeof(self) weakSelf = self;
    self.sheet.delegate = self;
    [self.sheet show:self];
    return NO;
}

- (void)changeDateValue:(KNDateChooseModel *)dateModel{
    self.workDays.text = [NSString stringWithFormat:@"%ld",(long)dateModel.workDays];
    self.restDays.text = [NSString stringWithFormat:@"%ld",(long)dateModel.restDays];
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd"; // 设置时间和日期的格式
    NSString *dateAndTime = [selectDateFormatter stringFromDate:dateModel.firstWorkDay]; // 把date类型转为设置好格式的string类型
    self.chooseFirstDay.text =dateAndTime;
}


#pragma  mark action sheet delegate 
- (void)actionCancle
{
    [self.sheet dismiss:self];
    
}
- (void)actionDoneDateChoosed:(NSDate *)chosedDate
{
//    self.dateChooseModel.firstWorkDay = chosedDate;
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy-MM-dd"; // 设置时间和日期的格式
    NSString *dateAndTime = [selectDateFormatter stringFromDate:chosedDate]; // 把date类型转为设置好格式的string类型
    self.chooseFirstDay.text =dateAndTime;
    self.tempDate = chosedDate;
    [self.sheet dismiss:self];
    
}
- (void)commitDate{
    self.dateChooseModel.workDays = [self.workDays.text integerValue];
    self.dateChooseModel.restDays = [self.restDays.text integerValue];
    NSString *firstDayStr = self.chooseFirstDay.text;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[formatter dateFromString:firstDayStr];
    self.dateChooseModel.firstWorkDay = date;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.dateChooseModel];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"ChosedDate"];
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)hiddenKeyboard
{
//    [self.view becomeFirstResponder];
      [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (void)hiddenKeyboardAndCanlender
{
    [self hiddenKeyboard];
    if (self.sheet) {
        [self.sheet dismiss:self];
    }
}

- (void)naviClickBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
