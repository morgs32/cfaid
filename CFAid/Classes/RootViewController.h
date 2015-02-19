//
//  RootViewController.h
//  CFAid
//
//  Created by Morgan Intrator on 8/3/09.
//  Copyright 2009 Pohleusis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface RootViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
	NSManagedObjectContext *managedObjectContext;
	NSArray *controllers;
}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSArray *controllers;

@end
