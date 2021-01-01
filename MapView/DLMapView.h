//
//  DLMapView.h
//  XBStore
//
//  Created by 刘松松 on 2018/7/10.
//  Copyright © 2018年 LSS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLParkingModel.h"
#import <AMapNaviKit/MAMapKit.h>

@interface DLMapView : UIView
@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, copy) void (^getLocation)(CLLocationCoordinate2D getLocation);
@property (nonatomic, copy) void (^selectTopMap)(DLParkingModel *topModel);
@property (nonatomic, assign) CLLocationCoordinate2D currentCoordinate;
@property (nonatomic, assign) BOOL isStartUpdataLocation;
@property (nonatomic, assign) BOOL isClearMap;
- (void)addParkingMessage:(DLParkingModel *)parking;
//- (void)update:(NSArray *)annotations;
@property(nonatomic,strong)NSMutableArray *images;

@end
