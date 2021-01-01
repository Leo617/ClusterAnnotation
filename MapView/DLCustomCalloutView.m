//
//  DLCustomCalloutView.m
//  XBStore
//
//  Created by 刘松松 on 2018/7/9.
//  Copyright © 2018年 LSS. All rights reserved.
//

#import "DLCustomCalloutView.h"

#define kCalloutWidth 150
#define kCalloutHeight 45
#define kArrorHeight 5
#define kWidth  50
#define kHeight 50
@interface DLCustomShowView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger timerNumber;
@property (nonatomic, assign) BOOL isStartCost;
@property (nonatomic, assign) long currentTimeNum;
@property (nonatomic, assign) long startTime;

@end
@implementation DLCustomShowView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
//    self.layer.shadowColor = [DEFAULT_TEXT_TITLET1 CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

- (void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
//    CGContextSetFillColorWithColor(context, DEFAULT_TEXT_TITLET1.CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 3.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

- (void)initSubViews
{
    // 添加图片，即商户图
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou"]];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-5);
        make.centerY.equalTo(self).offset(-5);
        make.width.mas_equalTo(6);
    }];
    
    self. titleLabel = [[UILabel alloc]init];
//    self.titleLabel.font = FONT_MEDIUM(12);
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(5);
        make.right.equalTo(imageView.mas_left).offset(-5);
    }];
    
    self.detailLabel = [[UILabel alloc]init];
//    self.detailLabel.textColor = DEFAULT_ASSIST_BLUET6;
//    self.detailLabel.font = FONT_MEDIUM(10);
    [self addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
    [sender addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sender];
    [sender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
   
//    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
//    [self addGestureRecognizer:recognizer];
}

- (void)tapAction
{
//    if (self.parkingModel)
//    {
//        [[NSNotificationCenter defaultCenter] postNotificationName:DLSelectParkingNotification object:@{@"parking":self.parkingModel}];
//    }
}

//- (void)setParkingModel:(DLParkingModel *)parkingModel
//{
//    _parkingModel = parkingModel;
//    if (_parkingModel.__isOrder && _parkingModel.__payStatus == 1)
//    {
//        self.titleLabel.text = [NSString stringWithFormat:@"停车计时:%@",[EngineTools getSpaceTime:_parkingModel.__parkingTime]];
//        self.detailLabel.text = [NSString stringWithFormat:@"%@,已开始计费",_parkingModel.__orderTrackState];
//
//    }
//    else if (_parkingModel.__isOrder)
//    {
//        if (self.timeInterval)
//        {
//            [self.timer invalidate];
//            self.timer = nil;
//        }
//        [self timeStart];
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeStart) userInfo:nil repeats:YES];
//    }
//    else
//    {
//        self.titleLabel.text = _parkingModel.parkingName;
//        self.detailLabel.text = [NSString stringWithFormat:@"¥%.0f元/h  %ld空闲/%ld总",_parkingModel.price,_parkingModel.useNum,_parkingModel.parkingSpaceNumber];
//    }
//}

- (void)timeStart
{
    
//    self.currentTimeNum = [[NSDate date] timeIntervalSince1970];
//    if (_parkingModel.__startTime/1000 < self.currentTimeNum)
//    {
//
//        self.startTime = (self.currentTimeNum - _parkingModel.__startTime/1000);
//        DLog(@"starttime = %ld  parkingTime==%ld  currentTime == %ld",self.startTime,_parkingModel.__startTime,self.currentTimeNum);
//        self.titleLabel.text = [NSString stringWithFormat:@"停车计时:%@",[EngineTools getSpaceTime:self.startTime]];
//        self.detailLabel.text = [NSString stringWithFormat:@"%@,已开始计费",_parkingModel.__orderTrackState];
//    }
//    else
//    {
//        self.titleLabel.text = @"已预约";
//        self.detailLabel.text = @"未开始计费";
//    }
//
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    if (self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)dealloc
{
    if (self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end

@implementation DLCustomCalloutView

- (instancetype)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
        
        self.backgroundColor = [UIColor clearColor];
        
        /* Create portrait image view and add to view hierarchy. */
        UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        backImageView.contentMode = UIViewContentModeScaleAspectFill;
        backImageView.clipsToBounds = YES;
        [self addSubview:backImageView];
        self.coverImageView = backImageView;
        self.coverImageView.center = CGPointMake(kWidth / 2.f+ 11 ,kHeight / 2.f+ 8);
        GBViewRadius(self.coverImageView, 4);
        
        self.hub = [[RKNotificationHub alloc]initWithView:self];
        [self.hub moveCircleByX:15 Y:0];
        [self.hub setCircleColor:[UIColor colorWithHexString:@"#FF4133"] labelColor:[UIColor whiteColor]];
        [self.hub scaleCircleSizeBy:0.65];
        self.hub.countLabelFont = Fit_Font(10);
        /* Create name label. */
//        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,5,kWidth - 10,kHeight - 15)];
//        self.titleLabel.backgroundColor  = [UIColor clearColor];
//        self.titleLabel.textAlignment    = NSTextAlignmentCenter;
//        self.titleLabel.textColor        = [UIColor whiteColor];
//        self.titleLabel.font             = [UIFont systemFontOfSize:10.f];
//        [self addSubview:self.titleLabel];
    }
    return self;
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    if (self.selected == selected)
//    {
//        return;
//    }
//
//    if (selected)
//    {
//        if (self.calloutView == nil)
//        {
//            self.calloutView = [[DLCustomShowView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
//            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
//                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
//        }
//
////        self.calloutView.titleString = [UIImage imageNamed:@"building"];
//        self.calloutView.titleString = self.annotation.title;
////        self.calloutView.detailString = self.annotation.subtitle;
////        self.calloutView.parkingModel = self.parkingModel;
//        [self addSubview:self.calloutView];
//    }
//    else
//    {
//        [self.calloutView removeFromSuperview];
//    }
//
//    [super setSelected:selected animated:animated];
//}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    BOOL inside = [super pointInside:point withEvent:event];
//    /* Points that lie outside the receiver’s bounds are never reported as hits,
//     even if they actually lie within one of the receiver’s subviews.
//     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
//     */
//    if (!inside && self.selected)
//    {
//        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
//    }
//    
//    return inside;
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
