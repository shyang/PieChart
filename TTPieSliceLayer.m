//
//  TTPieSliceLayer.m
//  SLMobile
//
//  Created by shaohua on 9/29/13.
//
//

#import "TTPieSliceLayer.h"

@implementation TTPieSliceLayer

// http://www.nomadplanet.fr/2010/11/animate-calayer-custom-properties-with-coreanimation/
+ (BOOL)needsDisplayForKey:(NSString *)key {
    return [key isEqualToString:@"startAngle"]
        || [key isEqualToString:@"endAngle"]
        || [super needsDisplayForKey:key];
}

- (id)initWithLayer:(TTPieSliceLayer *)layer {
	if (self = [super initWithLayer:layer]) {
		if ([layer isKindOfClass:[TTPieSliceLayer class]]) {
			_startAngle = layer.startAngle;
			_endAngle = layer.endAngle;
		}
	}
	return self;
}

- (void)drawInContext:(CGContextRef)ctx {
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height) / 2;

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:_startAngle endAngle:_endAngle clockwise:YES];
    [path addLineToPoint:center];
    [path closePath];

    CGContextAddPath(ctx, path.CGPath);
    CGContextSetFillColorWithColor(ctx, self.fillColor);
    CGContextFillPath(ctx);
}

- (CABasicAnimation *)makeAnimationForKeyPath:(NSString *)keyPath {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:keyPath];
    anim.fromValue = @0;
    anim.toValue = [self valueForKey:keyPath];
    anim.duration = 1;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return anim;
}

- (void)startRotating {
    [self addAnimation:[self makeAnimationForKeyPath:@"startAngle"] forKey:@"startAngle"];
    [self addAnimation:[self makeAnimationForKeyPath:@"endAngle"] forKey:@"endAngle"];
}

@end
