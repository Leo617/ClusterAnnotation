//
//  DLNavMapView.h
//  XBStore
//
//  Created by 刘松松 on 2018/7/18.
//  Copyright © 2018年 LSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLNavCustomMapView : UIView
@property (nonatomic, assign) CLLocationCoordinate2D aimPoint;
@property (nonatomic, copy) void (^closeAction)(BOOL close);
@end
