//
//  DLParkingModel.h
//  XBStore
//
//  Created by 刘松松 on 2018/7/9.
//  Copyright © 2018年 LSS. All rights reserved.
//


@interface DLParkingModel : NSObject

@property (nonatomic, assign) NSInteger parkingSpaceNumber;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, assign) NSInteger useNum;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, copy) NSString *parkingId;
@property (nonatomic, copy) NSString *parkingName;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *parkingPic;
@property (nonatomic, copy) NSString *__orderId;
@property (nonatomic, assign) BOOL __isOrder;
@property (nonatomic, assign) long __startTime;
@property (nonatomic, copy) NSString *__orderTrackState;
@property (nonatomic, assign) NSInteger __payStatus;
@property (nonatomic, assign) long __parkingTime;

@property (nonatomic, assign) NSInteger articleId;
@property (nonatomic, assign) NSInteger fileCategory;
@property (nonatomic, assign) NSInteger fileId;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, copy) NSString *squareFileCover;
@property (nonatomic, copy) NSString *thumbnailUrl;

@end
