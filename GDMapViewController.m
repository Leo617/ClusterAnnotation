//
//  GDMapViewController.m
//  MapAnnotationClusterDemo
//
//  Created by MrChen on 2018/7/27.
//  Copyright © 2018年 MrChen. All rights reserved.
//

#import "GDMapViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import "AnnotationManager.h"
#import "DpPositionAnnotationView.h"
#import "CoordinateQuadTree.h"
#import "ClusterAnnotation.h"
#import "ClusterAnnotationView.h"
#import "GDClusterManager.h"
#import "DLParkingModel.h"
#import "DLCustomCalloutView.h"

@interface GDMapViewController ()<MAMapViewDelegate>

// mapview
@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, copy) NSArray <CLLocation *>*locaiotns;

@property (nonatomic, strong) GDClusterManager *clusterManager;

// <#name#>
@property (nonatomic, strong) NSArray<DpPositionCourierModel *> *annotations;
// <#name#>
@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation GDMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"高德地图点聚合";
    
    [self createMapView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.clusterManager = [[GDClusterManager alloc]initWithMapView:self.mapView];
//    [self loadAnnotations];
}

- (void)createMapView
{

    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds]
    ;
    
    // 不可旋转
    mapView.rotateEnabled = NO;
    // 不可以相机角度看地图
    mapView.rotateCameraEnabled = NO;
    // 隐藏指南针
    mapView.showsCompass = NO;
    
    mapView.delegate = self;
    
    [self.view addSubview:mapView];
    self.mapView = mapView;
    
    [self footprintRequest];

}

// 获取坐标点
- (void)loadAnnotations
{
    // 创建所有的标注
    NSMutableArray *locations = [NSMutableArray array];
    for (int j = 0; j < self.annotations.count; j++) {
        DpPositionCourierModel *cModel = self.annotations[j];
        
        if (cModel.latitude == 0 || cModel.longitude == 0) continue;
        
        CLLocation *location = [[CLLocation alloc]initWithLatitude:cModel.latitude longitude:cModel.longitude];
        [locations addObject:location];

    }
    
    DpPositionCourierModel *m = (DpPositionCourierModel *)self.annotations.firstObject;
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(m.latitude, m.longitude)];
    self.mapView.zoomLevel = 5;
    // 添加标注
    [self.clusterManager addAnnotations:locations];
}

// 获取足迹点
- (void)footprintRequest {
    [NetDataServerTool requestURL:URL_foot_footprint httpMethod:@"GET" headerParams:nil params:nil file:nil success:^(id responseData) {
//        NSLog(@"足迹 %@",responseData);
        self.annotations = [DpPositionCourierModel mj_objectArrayWithKeyValuesArray:responseData[@"data"]];
        [self loadAnnotations];
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark - MAMapViewDelegate
// 添加annotation
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[ClusterAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        DLCustomCalloutView *annotationView = (DLCustomCalloutView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        ClusterAnnotation *an = (ClusterAnnotation *)annotation;
        if (annotationView == nil)
        {
            annotationView = [[DLCustomCalloutView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:reuseIndetifier];
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
        }
        annotationView.image = [UIImage imageNamed:@"dingwei"];
        for (DpPositionCourierModel *model in self.annotations) {
            if (model.longitude == an.coverLocation.coordinate.longitude || model.latitude == an.coverLocation.coordinate.latitude) {
                [annotationView.coverImageView sd_setImageWithURL:GBImageURL(model.thumbnailUrl)];
                break;
            }
        }
        
        annotationView.hub.count = (int)[an count];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
//        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self.clusterManager updateAnnotations];
}

- (void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction
{
    [self.clusterManager updateAnnotations];
}

@end
