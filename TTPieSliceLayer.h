//
//  TTPieSliceLayer.h
//  SLMobile
//
//  Created by shaohua on 9/29/13.
//
//

#import <QuartzCore/QuartzCore.h>

@interface TTPieSliceLayer : CAShapeLayer

@property (nonatomic) CGFloat startAngle;
@property (nonatomic) CGFloat endAngle;

- (void)startRotating;

@end
