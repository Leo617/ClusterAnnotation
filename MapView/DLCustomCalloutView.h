//
//  DLCustomCalloutView.h
//  XBStore
//
//  Created by 刘松松 on 2018/7/9.
//  Copyright © 2018年 LSS. All rights reserved.
//

#import <AMapNaviKit/MAMapKit.h>
#import "DLParkingModel.h"
#import "RKNotificationHub.h"

@interface DLCustomShowView : UIView
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *detailString;
@property (nonatomic, strong) DLParkingModel *parkingModel;
@property (nonatomic, assign) BOOL isCloseTimer;
@end
@interface DLCustomCalloutView : MAAnnotationView
// <#name#>
@property (nonatomic, strong) RKNotificationHub *hub;

@property (nonatomic, strong) DLCustomShowView *calloutView;
@property (nonatomic, strong) DLParkingModel *parkingModel;
@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) NSMutableArray <CLLocation *> *pois;

@end
