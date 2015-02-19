//
//  GraphViewController.h
//  CFAid
//
//  Created by Morgan Intrator on 11/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface GraphViewController : UIViewController {

	NSInteger right;
	NSInteger wrong;
}
@property (nonatomic) NSInteger right;
@property (nonatomic) NSInteger wrong;

- (void) setupView;
- (void) endSessionClicked: (id)sender;

@end
