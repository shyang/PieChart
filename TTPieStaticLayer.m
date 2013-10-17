//
//  TTPieStaticLayer.m
//  SLMobile
//
//  Created by shaohua on 9/30/13.
//
//

#import "TTPieStaticLayer.h"

@implementation TTPieStaticLayer

- (void)drawInContext:(CGContextRef)ctx {
    UIGraphicsPushContext(ctx);

    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height) / 2;

    // white inner circle
    [[UIColor colorWithWhite:1 alpha:1] setFill];
    UIBezierPath *circle = [UIBezierPath bezierPathWithArcCenter:center radius:radius / 3 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [circle fill];

    UIFont *font = [UIFont systemFontOfSize:radius / 4];
    // inner-most %
    [[UIColor grayColor] set];
    [@"%" drawInRect:CGRectMake(center.x - radius / 8, center.y - radius / 8, radius / 4, radius / 4) withFont:font];

    UIGraphicsPopContext();
}

@end
