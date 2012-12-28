//
//  UIGradientTableHeaderView.m
//  RentRoll
//
//  Created by Bob Ashmore on 23/12/2011.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "UIGradientTableHeaderView.h"

@implementation UIGradientTableHeaderView

@synthesize startColor;
@synthesize endColor;

-(void)setGradientStart:(UIColor *)sc andEnd:(UIColor *)ec 
{
    self.startColor = sc;
    self.endColor = ec;
}

- (void)drawRect:(CGRect)rect 
{
    
    if(startColor != nil && endColor != nil) {
        CGGradientRef   gradient;
        CGContextRef    ctx = UIGraphicsGetCurrentContext();
        
        CGFloat startColorR,startColorG,startColorB,startColorA;
        CGFloat endColorR,endColorG,endColorB,endColorA;
        
        [self.startColor getRed:&startColorR green:&startColorG blue:&startColorB alpha:&startColorA];
        [self.endColor getRed:&endColorR green:&endColorG blue:&endColorB alpha:&endColorA];
        
        CGFloat colors[8] = {startColorR, startColorG, startColorB, startColorA, endColorR, endColorG, endColorB, endColorA };
        CGFloat locations[2] = { 0.05f, 0.95f};
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        gradient = CGGradientCreateWithColorComponents(colorSpace,colors,locations,2);
        CGColorSpaceRelease(colorSpace);
        
        CGPoint startPoint = CGPointMake(CGRectGetMidX(self.bounds),0.0);
        CGPoint endPoint = CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMaxY(self.bounds));
        CGContextDrawLinearGradient(ctx,gradient,startPoint,endPoint,0);
        CGGradientRelease(gradient);
        gradient = nil;
    }
}

@end
