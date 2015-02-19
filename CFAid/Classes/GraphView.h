//
//  GraphView.h
//  CFAid
//
//  Created by Morgan Intrator on 11/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <math.h>


@interface GraphView : UIView {
	
	CGFloat right;
	CGFloat wrong;
	float total;
	float right_start;
	float right_finish;
	float wrong_finish;	
}

@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat wrong;

@end
