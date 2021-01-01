//
//  DLNavMapView.m
//  XBStore
//
//  Created by 刘松松 on 2018/7/18.
//  Copyright © 2018年 LSS. All rights reserved.
//

#import "DLNavCustomMapView.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "SpeechSynthesizer.h"
@interface DLNavCustomMapView () <AMapNaviDriveViewDelegate,AMapNaviDriveManagerDelegate,AMapLocationManagerDelegate>
@property (nonatomic, strong) AMapNaviDriveView *driveView;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, assign) CLLocationCoordinate2D startPoint;
@end

@implementation DLNavCustomMapView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.driveView = [[AMapNaviDriveView alloc]init];
        self.driveView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.driveView.delegate = self;
        [self addSubview:self.driveView];
        [self.driveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [AMapNaviDriveManager sharedInstance].delegate = self;
        [[AMapNaviDriveManager sharedInstance] addDataRepresentative:self.driveView];
        
        self.locationManager = [[AMapLocationManager alloc]init];
        self.locationManager.delegate = self;
        
    }
    return self;
}

- (void)setAimPoint:(CLLocationCoordinate2D)aimPoint
{
    _aimPoint = aimPoint;
    [self.locationManager startUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"wei zhi %.f,  %.f",location.coordinate.latitude,location.coordinate.longitude);
    self.startPoint = location.coordinate;
//    [UserInfoManager manager].loginUser.__latitude = location.coordinate.latitude;
//    [UserInfoManager manager].loginUser.__longitude = location.coordinate.longitude;
//    [[UserInfoManager manager] save:[UserInfoManager manager].loginUser];
    AMapNaviPoint *startPoint = [AMapNaviPoint locationWithLatitude:self.startPoint.latitude longitude:self.startPoint.longitude];
    AMapNaviPoint *endPoint = [AMapNaviPoint locationWithLatitude:self.aimPoint.latitude longitude:self.aimPoint.longitude];
    [[AMapNaviDriveManager sharedInstance] calculateDriveRouteWithStartPoints:@[startPoint]
                                                                    endPoints:@[endPoint]
                                                                    wayPoints:nil
                                                              drivingStrategy:17];
    [self.locationManager stopUpdatingLocation];
}

- (void)driveViewCloseButtonClicked:(AMapNaviDriveView *)driveView
{
    if (self.closeAction) {
        self.closeAction(YES);
    }
}

- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"onCalculateRouteSuccess");
    
    //算路成功后开始GPS导航
    [[AMapNaviDriveManager sharedInstance] startGPSNavi];
}

- (BOOL)driveManagerIsNaviSoundPlaying:(AMapNaviDriveManager *)driveManager
{
    return [[SpeechSynthesizer sharedSpeechSynthesizer] isSpeaking];
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    [[SpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];
}

- (void)dealloc
{
    [[AMapNaviDriveManager sharedInstance] stopNavi];
    [[AMapNaviDriveManager sharedInstance] removeDataRepresentative:self.driveView];
    [[AMapNaviDriveManager sharedInstance] setDelegate:nil];
    [AMapNaviDriveManager destroyInstance];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
