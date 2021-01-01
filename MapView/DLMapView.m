//
//  DLMapView.m
//  XBStore
//
/////

#import "DLMapView.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "DLCustomPointAnnotation.h"
#import "DLCustomCalloutView.h"

@interface DLMapView ()<AMapLocationManagerDelegate,MAMapViewDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;
@end
@implementation DLMapView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [AMapServices sharedServices].enableHTTPS = YES;
        self.mapView = [[MAMapView alloc]init];
        self.mapView.showsCompass = NO;
        self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.mapView.showsScale = NO;
        self.mapView.zoomLevel = 15;
        self.mapView.delegate = self;
        [self addSubview:self.mapView];
        [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        self.mapView.showsUserLocation = YES;
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        MAUserLocationRepresentation *representation = [[MAUserLocationRepresentation alloc]init];
        representation.showsHeadingIndicator = YES;
        representation.showsAccuracyRing = NO;
        //    representation.fillColor = DEFAULT_ASSIST_BLUET6;
        //    representation.strokeColor = DEFAULT_BG_COLORB1;
        //    representation.lineWidth = 2;
        representation.image = [UIImage imageNamed:@"椭圆7拷贝"];
        [self.mapView updateUserLocationRepresentation:representation];
        
        self.locationManager = [[AMapLocationManager alloc]init];
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
        
        UIButton *roadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [roadButton addTarget:self action:@selector(enterMapTrafficAction:) forControlEvents:UIControlEventTouchUpInside];
        [roadButton setImage:[UIImage imageNamed:@"lukuang"] forState:UIControlStateNormal];
        [roadButton setImage:[UIImage imageNamed:@"aavv"] forState:UIControlStateSelected];
        [self addSubview:roadButton];
        [roadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self).offset(60);
        }];
        
        UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [centerButton addTarget:self action:@selector(enterMapCenterAction) forControlEvents:UIControlEventTouchUpInside];
        [centerButton setImage:[UIImage imageNamed:@"aaa"] forState:UIControlStateNormal];
        [self addSubview:centerButton];
        [centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(roadButton);
            make.top.equalTo(roadButton.mas_bottom).offset(10);
        }];

    }
    return self;
}

- (void)enterMapTrafficAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    
    [self.mapView setShowTraffic:!self.mapView.showTraffic];
    
}

- (void)addParkingMessage:(DLParkingModel *)parking
{
//    CLLocationCoordinate2D randomCoordinate = [self.mapView convertPoint:[self randomPoint] toCoordinateFromView:self];
//    [self addAnnotationWithCooordinate:randomCoordinate];
//    DLCustomPointAnnotation *point = [[DLCustomPointAnnotation alloc]init];
//    //                MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
//    point.parkingModel = parking;
//    point.coordinate = CLLocationCoordinate2DMake(parking.latitude, parking.longitude);
//    point.title = [NSString stringWithFormat:@"%ld",parking.useNum];
//    
//    [self.mapView addAnnotation:point];
//    if (parking.__isOrder)
//    {
//        [self.mapView selectAnnotation:point animated:YES];
//    }
}

- (void)setIsClearMap:(BOOL)isClearMap
{
    _isClearMap = isClearMap;
    if (_isClearMap)
    {
        [self.mapView removeOverlays:self.mapView.overlays];
        [self.mapView removeAnnotations:self.mapView.annotations];
    }
}

- (void)enterMapCenterAction
{
    if (self.userLocationAnnotationView)
    {
        [self.mapView setCenterCoordinate:self.userLocationAnnotationView.annotation.coordinate animated:YES];
    }
}
//TODO：测试用
- (CGPoint)randomPoint
{
    CGPoint randomPoint = CGPointZero;
    
    randomPoint.x = arc4random() % (int)(CGRectGetWidth(self.bounds));
    randomPoint.y = arc4random() % (int)(CGRectGetHeight(self.bounds));
    
    return randomPoint;
}

- (void)setIsStartUpdataLocation:(BOOL)isStartUpdataLocation
{
    _isStartUpdataLocation = isStartUpdataLocation;
    if (_isStartUpdataLocation)
    {
        [self.locationManager startUpdatingLocation];
    }
}


-(void)addAnnotationWithCooordinate:(CLLocationCoordinate2D)coordinate
{
    MAPointAnnotation *annotation = [[DLCustomPointAnnotation alloc] init];
    annotation.coordinate = coordinate;
    annotation.title    = @"As";
    annotation.subtitle = @"Cusggg";
    
    [self.mapView addAnnotation:annotation];
    [self.mapView selectAnnotation:annotation animated:YES];
}

#pragma mark 地图代理

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {
//        MAUserLocation *userLocation = (MAUserLocation *)annotation;
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:userLocationStyleReuseIndetifier];
        }
//        DLog(@"showUser location  latitude== %f  longitude== %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        annotationView.image = [UIImage imageNamed:@"椭圆7拷贝"];
        self.userLocationAnnotationView = annotationView;
        
//        [self requestData];
        return annotationView;
    }
    else if ([annotation isKindOfClass:[DLCustomPointAnnotation class]])
    {
        DLCustomPointAnnotation *anpoint = annotation;
        
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        DLCustomCalloutView *annotationView = (DLCustomCalloutView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[DLCustomCalloutView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:reuseIndetifier];
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
        }
        annotationView.parkingModel = anpoint.parkingModel;
        annotationView.image = [UIImage imageNamed:@"dingwei"];
        [annotationView.coverImageView sd_setImageWithURL:GBImageURL(self.images[0])];

        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    
    return nil;
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"wei zhi %.f,  %.f",location.coordinate.latitude,location.coordinate.longitude);
    self.currentCoordinate = location.coordinate;
//    [UserInfoManager manager].loginUser.__latitude = location.coordinate.latitude;
//    [UserInfoManager manager].loginUser.__longitude = location.coordinate.longitude;
//    [[UserInfoManager manager] save:[UserInfoManager manager].loginUser];
    if (self.getLocation)
    {
        self.getLocation(self.currentCoordinate);
    }
    [self.locationManager stopUpdatingLocation];
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view
{
//        if ([view isKindOfClass:[DLCustomCalloutView class]])
//        {
//            DLCustomCalloutView *cunstomView = (DLCustomCalloutView *)view;
//            if (self.selectTopMap)
//            {
//                self.selectTopMap(cunstomView.parkingModel);
//            }
//        }
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (!updatingLocation && self.userLocationAnnotationView != nil)
    {
        [UIView animateWithDuration:0.1 animations:^{
            
            double degree = userLocation.heading.trueHeading - self.mapView.rotationDegree;
            self.userLocationAnnotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
            
        }];
    }
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"change head %@",newHeading);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
