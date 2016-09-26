//
//  KNDateChooseModel.m
//  KNCalendar
//
//  Created by zhukeshuai on 16/4/13.
//  Copyright © 2016年 maihaoche. All rights reserved.
//

#import "KNDateChooseModel.h"

@implementation KNDateChooseModel
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSNumber numberWithInteger:self.workDays] forKey:@"workDays"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.restDays] forKey:@"restDays"];
    [aCoder encodeObject:self.firstWorkDay forKey:@"firstWorkDay"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        if (decoder == nil)
        {
            return self;
        }
        self.workDays = [[decoder decodeObjectForKey:@"workDays"] integerValue];
        self.restDays = [[decoder decodeObjectForKey:@"restDays"] integerValue];
        self.firstWorkDay = [decoder decodeObjectForKey:@"firstWorkDay"];
        
    }
    return self;
}

@end
