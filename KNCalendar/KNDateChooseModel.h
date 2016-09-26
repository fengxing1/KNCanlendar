//
//  KNDateChooseModel.h
//  KNCalendar
//
//  Created by zhukeshuai on 16/4/13.
//  Copyright © 2016年 maihaoche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNDateChooseModel : NSObject
@property (nonatomic, assign) NSInteger workDays;
@property (nonatomic, assign) NSInteger restDays;
@property (nonatomic, strong) NSDate *firstWorkDay;

@end
