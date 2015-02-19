//
//  GraphView.m
//  CFAid
//
//  Created by Morgan Intrator on 11/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GraphView.h"




#define PI 3.14159265358979323846

static inline float radians(double degrees) {
	return degrees * PI / 180;
}

@implementation GraphView
@synthesize right;
@synthesize wrong;


- (void)drawRect:(CGRect)rect {	
	//CGRect parentViewBounds = self.bounds;
	CGFloat x = 120;
	CGFloat y = 122.5;
	
	self.backgroundColor = [UIColor clearColor];
	
	//Get the graphics context and clear it
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	//define line width
	CGContextSetLineWidth(context, 4.0);
	
	total = right + wrong;
		
	right_finish = (right/total)*360;
	right_start = -90;
	wrong_finish = (wrong/total)*360;
	
	//Wrong slice
	CGContextSetFillColor(context, CGColorGetComponents([[UIColor colorWithRed:15 green:165/255 blue:0 alpha:1] CGColor]));
	CGContextMoveToPoint(context, x, y);
	CGContextAddArc(context, x, y, 100, radians(right_start + right_finish), radians(right_start + right_finish + wrong_finish), 0);
	CGContextClosePath(context);
	CGContextFillPath(context);
	
	//Right slice
	CGContextSetFillColor(context, CGColorGetComponents([[UIColor colorWithRed:0 green:15 blue:0 alpha:1] CGColor]));
	CGContextMoveToPoint(context, x + (6 * sin(radians(right_finish/2))), y - (6 * cos(radians(right_finish/2))));
	CGContextAddArc(context, x + (6 * sin(radians(right_finish/2))), y - (6 * cos(radians(right_finish/2))), 
					100, radians(right_start), radians(right_start + right_finish), 0);
	CGContextClosePath(context);
	CGContextFillPath(context);
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}


@end
