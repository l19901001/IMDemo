//
//  SSAnimationView.m
//  IMDemo
//
//  Created by lss on 2017/6/12.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "SSAnimationView.h"

@interface SSAnimationView ()

@property (nonatomic, strong) CAShapeLayer *animationLayer;

@end

@implementation SSAnimationView

-(instancetype)init
{
    self = [super init];
    if(self){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)startAnimation
{
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.fillMode = kCAFillModeForwards;
    anima.removedOnCompletion = NO;
    anima.duration = 0.8;
    anima.keyPath = @"transform.rotation";
    anima.toValue = @(M_PI*2);
    anima.repeatCount = MAXFLOAT;
    [self.layer addAnimation:anima forKey:nil];
}

-(void)stopAniamtion
{
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, rect.size.width/2, rect.size.height/2, rect.size.width/2-2, -M_PI_2, M_PI*2, YES);
    CGContextSetLineWidth(context, 2.f);
    [[UIColor grayColor] setStroke];
    CGContextStrokePath(context);
}


@end
