//
//  BrowseTopicController.h
//  CFAid
//
//  Created by Morgan Intrator on 11/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "SecondLevelController.h"


@interface BrowseTopicsController : SecondLevelController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate> {
	UITableViewCell *studyButtonCell;
	NSFetchRequest *fetch;
}
@property (nonatomic, assign) IBOutlet UITableViewCell *studyButtonCell;
@property (nonatomic, retain) NSFetchRequest *fetch;

@end
