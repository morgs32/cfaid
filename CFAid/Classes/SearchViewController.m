//
//  SearchViewController.m
//  CFAid
//
//  Created by Morgan Intrator on 9/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import "BrowseCardsController.h"
#import "CFAidAppDelegate.h"
#import "Card.h"

@implementation SearchViewController
@synthesize searchButtonCell;
@synthesize managedObjectModel;
@synthesize fetchedResultsController;
@synthesize search;

#pragma mark -
#pragma mark View lifecycle
- (void)viewWillAppear {
	[super viewWillAppear:NO];
	[self resetSearch];
	[self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
		self.navigationItem.titleView.frame = CGRectMake(0, 0, 325, 32);
	else
		self.navigationItem.titleView.frame = CGRectMake(0, 0, 325, 44);
	return (interfaceOrientation == UIInterfaceOrientationPortrait ||
			interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
			interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)viewDidLoad {
	UISearchBar *searchBar = [[UISearchBar alloc] init];
	searchBar.delegate = self;
	searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	
	self.search = searchBar;
	self.navigationItem.titleView = searchBar;
	self.navigationItem.titleView.frame = CGRectMake(0, 0, 325, 44);
	[searchBar release];

	[self resetSearch];
	
	self.tableView.scrollEnabled = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *) scrollView {
	[search resignFirstResponder];
}
 
#pragma mark
#pragma mark Custom Methods
- (void)resetSearch {
	NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
}
	
- (NSFetchedResultsController *)fetchedResultsController {
    // Create and configure a fetch request with the Book entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Card" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    // Create the sort descriptors array.
    NSSortDescriptor *numberDescriptor = [[NSSortDescriptor alloc] initWithKey:@"numberOrder" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:numberDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    // Create and initialize the fetch results controller.
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] 
															 initWithFetchRequest:fetchRequest
															 managedObjectContext:managedObjectContext
															 sectionNameKeyPath:nil
															 cacheName:@"All"];
	self.fetchedResultsController = aFetchedResultsController;
    // Memory management.
    [aFetchedResultsController release];
    [fetchRequest release];
    [numberDescriptor release];
    [sortDescriptors release];
    return fetchedResultsController;
}
	
- (void)handleSearchForTerm:(NSString *)searchTerm {
	// Create and configure a fetch request with the Card entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Card" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
	NSPredicate *predicate =[NSPredicate predicateWithFormat:@"front contains[cd] %@", search.text];
	[fetchRequest setPredicate:predicate];

    // Create the sort descriptors array.
    NSSortDescriptor *numberDescriptor = [[NSSortDescriptor alloc] initWithKey:@"numberOrder" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:numberDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Create and initialize the fetch results controller.
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] 
															 initWithFetchRequest:fetchRequest
															 managedObjectContext:managedObjectContext
															 sectionNameKeyPath:nil
															 cacheName:nil];
	
	self.fetchedResultsController = aFetchedResultsController;
    
    // Memory management.
    [aFetchedResultsController release];
    [fetchRequest release];
    [numberDescriptor release];
    [sortDescriptors release];
	
	NSError *error = nil;
	if (![fetchedResultsController performFetch:&error]) {
		// Handle error
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}           
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
		
		NSUInteger count = [[fetchedResultsController sections] count];
		if (count == 0) {
			count = 1;
		}
		return count;
}
	
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSArray *sections = [fetchedResultsController sections];
	NSUInteger count = 0;
	if ([sections count]) {
		id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
		count = [sectionInfo numberOfObjects];
	}

	return count;
}
	
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *SearchButtonCellIdentifier =	@"SearchButtonCellIdentifier";
	
	UITableViewCell	*cell = [tableView dequeueReusableCellWithIdentifier: 
							 SearchButtonCellIdentifier];
	if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"SearchButtonCell" owner:self options:nil];
		cell = searchButtonCell;
		self.searchButtonCell = nil;
	}
	
	//Configure the cell.
	[self configureCell:cell atIndexPath:indexPath];
	return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell with data from the managed object.
	Card *card = [fetchedResultsController objectAtIndexPath:indexPath];
	UILabel *label;
	label = (UILabel *)[cell viewWithTag:1];
	label.text = [card front];
	label = (UILabel *)[cell viewWithTag:2];
	label.text = [NSString stringWithFormat:@"%@", [card numberOrder]];
}

#pragma mark -
#pragma mark Table Delegate Methods
- (void) tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Card *card = [fetchedResultsController objectAtIndexPath:indexPath];
	NSMutableArray *cardArray = [NSMutableArray arrayWithObject:card];
	BrowseCardsController *nextNavController = [[BrowseCardsController alloc] init];
	nextNavController.cardsArray = cardArray;
	nextNavController.managedObjectContext = managedObjectContext;
	CFAidAppDelegate *delegate = 
	[[UIApplication sharedApplication] delegate];
	[delegate.navigationController presentModalViewController:nextNavController animated:YES];
	[nextNavController release];
}


#pragma mark -
#pragma mark Search Bar Delegate Methods


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchTerm
{
	int length = [[searchTerm stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length];
	
	if (length == 0 || searchTerm == nil)
	{
		[self resetSearch];
		[self.tableView reloadData];
		return;
	}
	[self handleSearchForTerm:searchTerm];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	search.text = @"";
	[self resetSearch];
	[self.tableView reloadData];
	[searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark View lifecycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	NSLog(@"Memory Warning"); 
}

- (void)dealloc {
	[managedObjectContext release];
	[buttonLabel release];
	[managedObjectModel release];
	[fetchedResultsController release];
    [super dealloc];
}

@end
