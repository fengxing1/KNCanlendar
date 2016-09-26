//
//  ViewController.m
//  KNCalendar
//
//  Created by zhukeshuai on 16/4/8.
//  Copyright © 2016年 maihaoche. All rights reserved.
//

#import "ViewController.h"
#import "CalendarHomeViewController.h"
#import "KNSettingCalendarViewController.h"

@import GoogleMobileAds;

static NSString *const kBannerAdUnitID = @"ca-app-pub-7636781886170182/3681180954";
static NSString *const kInterstitialAdUnitID = @"ca-app-pub-3940256099942544/4411468910";

@interface ViewController ()<GADInterstitialDelegate>{
    CalendarHomeViewController *chvc;
}
@property (nonatomic, strong) GADInterstitial *interstitial;
//@property (nonatomic, strong) GADBannerView *bannerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"轮班日历";
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"profile_set"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(calendarSetting)];

    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    chvc = [[CalendarHomeViewController alloc]init];
    chvc.view.frame=CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:chvc.view];

    
    // Replace this ad unit ID with your own ad unit ID.
    self.bannerView.adUnitID = kBannerAdUnitID;
    
    self.bannerView.rootViewController = self;
    [self.view bringSubviewToFront:self.bannerView];
    
    GADRequest *request = [GADRequest request];
    // Requests test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made. GADBannerView automatically returns test ads when running on a
    // simulator.
    //  request.testDevices = @[
    //    @"2077ef9a63d2b398840261c8221a0c9a"  // Eric's iPod Touch
    //  ];
    [self.bannerView loadRequest:request];
    self.interstitial = [self createAndLoadInterstitial];
    if ([self.interstitial isReady]) {
        [self.interstitial presentFromRootViewController:self];
    }
//    request.testDevices
    
}


- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *interstitial = [[GADInterstitial alloc]
                                     initWithAdUnitID:kInterstitialAdUnitID];
    interstitial.delegate = self;
    [interstitial loadRequest:[GADRequest request]];
    return interstitial;
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    self.interstitial = [self createAndLoadInterstitial];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置NavigationBar背景颜色
    // Do any additional setup after loading the view, typically from a nib.
   //    [self.view bringSubviewToFront:self.bannerView];
    [chvc setAirPlaneToDay:730 ToDateforString:nil];//飞机初始化方法
    chvc.calendarblock = ^(CalendarDayModel *model){
        
        
        NSLog(@"%@",[model toString]);
        
        if(model.style==CellDayTypeClick)
        {
            
            
        }
        else
        {
            
        }
        
    };
}

- (void)calendarSetting
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KNSettingCalendarViewController *settingVC = [storyBoard instantiateViewControllerWithIdentifier:@"KNSettingCalendar"];
    [self.navigationController pushViewController:settingVC animated:YES];
//    [self presentViewController:settingVC animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
