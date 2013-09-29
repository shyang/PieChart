//
//  TTPieView.m
//  SLMobile
//
//  Created by shaohua on 9/29/13.
//
//

#import "TTPieView.h"
#import "TTPieSliceLayer.h"

@implementation TTPieView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (void)setObject:(id)item {
    double sum = 0;
    for (NSNumber *number in item) {
        sum += [number doubleValue];
    }

    CGFloat startAngle = 0;
    for (int i = 0; i < [item count]; ++i) {
        CGFloat endAngle = startAngle + M_PI * 2 * ([item[i] doubleValue] / sum);

        TTPieSliceLayer *layer = [TTPieSliceLayer layer];
        layer.frame = self.layer.bounds;
        [layer setNeedsDisplay];
        layer.startAngle = startAngle;
        layer.endAngle = endAngle;

        UIColor *color = [UIColor colorWithRed:i % 3 == 0 green:i % 3 == 1 blue:i % 3 == 2 alpha:.5];
        layer.fillColor = color.CGColor;

        [self.layer addSublayer:layer];
        startAngle = endAngle;
        [layer startRotating];
    }
}

@end
