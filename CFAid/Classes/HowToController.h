//
//  HowToController.h
//  CFAid
//
//  Created by Morgan Intrator on 11/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondLevelController.h"


@interface HowToController : UIViewController {
	UIImage *buttonImage;
	NSString *buttonLabel;
	IBOutlet UIScrollView *scrollView;
}
@property (nonatomic, retain) UIImage *buttonImage;
@property (nonatomic, retain) NSString *buttonLabel;
@property (nonatomic, retain) UIScrollView *scrollView;

- (void)setupView;

@end
