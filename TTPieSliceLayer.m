//
//  TTPieSliceLayer.m
//  SLMobile
//
//  Created by shaohua on 9/29/13.
//
//

#import <UIKit/UIKit.h>

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
    UIGraphicsPushContext(ctx);
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height) / 2;

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:_startAngle endAngle:_endAngle clockwise:YES];
    [path addLineToPoint:center];
    [path closePath];

    CGContextSetFillColorWithColor(ctx, self.fillColor);
    [path fill];

    [[UIColor whiteColor] set];

    CGFloat percent = (_endAngle - _startAngle) / M_PI / 2 * 100;
    NSString *text = [NSString stringWithFormat:@"%d", (int)MIN(100, ABS(percent))];
    CGFloat mid = (_endAngle + _startAngle) / 2;
    CGFloat x = .6 * radius * cosf(mid) + center.x;
    CGFloat y = .6 * radius * sinf(mid) + center.y;

    UIFont *font = [UIFont systemFontOfSize:radius / 4];
    CGSize textSize = [text sizeWithFont:font];
    CGRect textRect = CGRectMake(x - textSize.width / 2, y - textSize.height / 2, textSize.width, textSize.height);
    [text drawInRect:textRect withFont:font];

    UIGraphicsPopContext();
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
