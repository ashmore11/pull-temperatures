//
//  UIGradientTableHeaderView.h
//  RentRoll
//
//  Created by Bob Ashmore on 23/12/2011.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGradientTableHeaderView : UIView
@property (strong, nonatomic) IBOutlet UIColor *startColor;
@property (strong, nonatomic) IBOutlet UIColor *endColor;

-(void)setGradientStart:(UIColor *)sc andEnd:(UIColor *)ec;

@end
