//
//  StudyButtonController.h
//  CFAid
//
//  Created by Morgan Intrator on 8/19/09.
//  Copyright 2009 Pohleusis. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "SecondLevelController.h"

@interface StudyButtonController : SecondLevelController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate> {
	NSUInteger row;
	NSMutableArray *boxCounts;
	NSMutableArray *topics;
	NSMutableArray *titleNotes;
	NSManagedObjectModel *managedObjectModel;
	NSFetchRequest *fetch;
	UITableViewCell *studyButtonCell;

	
}
@property (nonatomic, retain) NSMutableArray *boxCounts;
@property (nonatomic, retain) NSMutableArray *topics;
@property (nonatomic, retain) NSMutableArray *titleNotes;
@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain) NSFetchRequest *fetch;
@property (nonatomic, assign) IBOutlet UITableViewCell *studyButtonCell;

- (NSInteger)runFetch:(NSInteger)tableBoxNumber;

@end
