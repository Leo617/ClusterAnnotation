//
//  DLCustomPointAnnotation.h
//  XBStore
//
//  Created by 刘松松 on 2018/7/9.
//  Copyright © 2018年 LSS. All rights reserved.
//

#import <AMapNaviKit/MAMapKit.h>
#import "DLParkingModel.h"

@interface DLCustomPointAnnotation : MAPointAnnotation
@property (nonatomic,strong) DLParkingModel *parkingModel;

@end
