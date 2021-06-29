//
//  ClusterAnnotationView.h
//  officialDemo2D
//
//  Created by yi chen on 14-5-15.
//  Copyright (c) 2014年 AutoNavi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapNaviKit/AMapNaviKit.h>


@interface ClusterAnnotationView : MAAnnotationView

@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) UIImageView *coverImageView;

@end
