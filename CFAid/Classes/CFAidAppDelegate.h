//
//  CFAidAppDelegate.h
//  CFAid
//
//  Created by Morgan Intrator on 8/3/09.
//  Copyright Pohleusis 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CFAidAppDelegate : NSObject <UIApplicationDelegate> {
	
	NSManagedObjectModel *managedObjectModel;
	NSManagedObjectContext *managedObjectContext;
	NSPersistentStoreCoordinator *persistentStoreCoordinator;
	
	IBOutlet UIWindow *window;
	IBOutlet UINavigationController *navigationController;
}


@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

@property (nonatomic, readonly) NSString *applicationDocumentsDirectory;

@end

