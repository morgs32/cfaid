//
//  ResourcesController.h
//  CFAid
//
//  Created by Morgan Intrator on 12/9/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ResourcesController : UIViewController {
	IBOutlet UIScrollView *scrollView;
}
@property (nonatomic, retain) UIScrollView *scrollView;

-(void)setupView;

@end
