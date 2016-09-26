//
//  KNSettingCalendarViewController.h
//  KNCalendar
//
//  Created by zhukeshuai on 16/4/9.
//  Copyright © 2016年 maihaoche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHCB2BActionSheet.h"

@interface KNSettingCalendarViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *workDays;
@property (weak, nonatomic) IBOutlet UITextField *restDays;

@property (weak, nonatomic) IBOutlet UITextField *chooseFirstDay;
@property (weak, nonatomic) IBOutlet UIView *backview;
@property (nonatomic, strong) MHCB2BActionSheet *sheet;

@property (nonatomic, strong) NSDate *tempDate;

//@property (nonatomic, strong) UIDatePicker *datePicker;
@end
