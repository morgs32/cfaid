//
//  SecondLevelController.h
//  CFAid
//
//  Created by Morgan Intrator on 9/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "Card.h"
#import "SecondLevelController.h"

@interface SearchViewController : SecondLevelController <NSFetchedResultsControllerDelegate, UISearchBarDelegate> {
	UITableViewCell *searchButtonCell;
	NSManagedObjectModel *managedObjectModel;
	NSFetchedResultsController *fetchedResultsController;
	UISearchBar *search;

}
@property (nonatomic, assign) IBOutlet UITableViewCell *searchButtonCell;
@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) UISearchBar *search;

- (void)resetSearch;
- (NSFetchedResultsController *)fetchedResultsController;
- (void)handleSearchForTerm:(NSString *)searchTerm;
- (void)configureCell:(UITableViewCell *) cell atIndexPath:(NSIndexPath *)indexPath;

@end
