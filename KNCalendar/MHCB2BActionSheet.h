//
//  MHCB2BActionSheet.h
//  MHCB2BApp
//
//  Created by zhukeshuai on 16/2/16.
//  Copyright © 2016年 maihaoche. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ProvinceAndCityPickerView.h"
@protocol SimulateActionSheetDelegate <NSObject>
//点击取消的回调接口
-(void)actionCancle;
//点击确定的回调接口
-(void)actionDoneDateChoosed:(NSDate *)chosedDate;
@end

@interface MHCB2BActionSheet : UIView
@property(assign, nonatomic) id<SimulateActionSheetDelegate> delegate;
@property(strong, nonatomic)UIView* toolBar;
//@property(strong, nonatomic)UIPickerView* pickerView;
@property (nonatomic, strong)UIDatePicker *pickerView;
@property (nonatomic, strong) NSDate *chosedDate;

+(instancetype)styleDefault;
-(void)show:(UIViewController *)controller;
-(void)dismiss:(UIViewController *)controller;
////选中指定的行列
//-(void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)anime;
////获取被选中的行列
//-(NSInteger)selectedRowInComponent:(NSInteger)component;

@end
