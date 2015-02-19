//
//  BrowseButtonController.h
//  CFAid
//
//  Created by Morgan Intrator on 8/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "SecondLevelController.h"

@class BrowseLeitnerBoxController;

@interface BrowseButtonController : SecondLevelController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate> {
	UITableViewCell *studyButtonCell;
	NSFetchRequest *fetch;
}
@property (nonatomic, assign) IBOutlet UITableViewCell *studyButtonCell;
@property (nonatomic, retain) NSFetchRequest *fetch;
	
@end
