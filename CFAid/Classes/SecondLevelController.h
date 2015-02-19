//
//  SecondLevelController.h
//  CFAid
//
//  Created by Morgan Intrator on 9/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface SecondLevelController : UITableViewController {
	NSManagedObjectContext *managedObjectContext;
	UIImage *buttonImage;
	NSString *buttonLabel;
	NSArray *list;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UIImage *buttonImage;
@property (nonatomic, retain) NSString *buttonLabel;
@property (nonatomic, retain) NSArray *list;

@end
