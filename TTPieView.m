//
//  TTPieView.m
//  SLMobile
//
//  Created by shaohua on 9/29/13.
//
//

#import "TTPieView.h"
#import "TTPieSliceLayer.h"
#import "TTPieStaticLayer.h"

@implementation TTPieView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

static float gColors[][3] = {
    {0.2588, 0.3490, 0.8510},
    {0.0000, 0.6314, 0.8431},
    {0.0000, 0.8706, 0.4667},
    {0.9333, 0.9804, 0.0000},
    {0.9922, 0.7373, 0.1255},
    {1.0000, 0.1412, 0.1961},
};

- (void)setObject:(id)item {
    for (id layer in [self.layer.sublayers copy]) {
        [layer removeFromSuperlayer];
    }

    double sum = 0;
    for (NSNumber *number in item) {
        sum += [number doubleValue];
    }

    // layers with animation
    CGFloat startAngle = 0;
    for (int i = 0; i < [item count]; ++i) {
        if ([item[i] doubleValue] <= 0) { // hide zero slice
            continue;
        }
        CGFloat endAngle = startAngle + M_PI * 2 * ([item[i] doubleValue] / sum);

        TTPieSliceLayer *layer = [TTPieSliceLayer layer];
        layer.frame = self.layer.bounds;
        layer.contentsScale = [UIScreen mainScreen].scale;
        [layer setNeedsDisplay];
        layer.startAngle = startAngle;
        layer.endAngle = endAngle;

        float *color = gColors[i % 6];
        layer.fillColor = [UIColor colorWithRed:color[0] green:color[1] blue:color[2] alpha:1].CGColor;

        [self.layer addSublayer:layer];
        startAngle = endAngle;
        [layer startRotating];
    }

    // layer without animation
    if (sum > 0) {
        TTPieStaticLayer *layer = [TTPieStaticLayer layer];
        layer.contentsScale = [UIScreen mainScreen].scale;
        layer.frame = self.layer.bounds;
        [layer setNeedsDisplay];
        [self.layer addSublayer:layer];
    }
}

@end
