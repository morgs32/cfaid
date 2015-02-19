//
//  BrowseButtonController.m
//  CFAid
//
//  Created by Morgan Intrator on 8/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BrowseButtonController.h"
#import "CFAidAppDelegate.h"
#import "BrowseTopicsController.h"
#import "BrowseCardsController.h"
#import "time.h"


@implementation BrowseButtonController
@synthesize studyButtonCell;
@synthesize fetch;

#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad {
	[super viewDidLoad];
	NSArray *array = [[NSArray alloc] initWithObjects: @"All", @"By Topic", @"Flagged", @"Formula & Graphs", nil];
	self.list = array;
	[array release];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	[self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
			interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
			interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark -
#pragma mark Memory management
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
}

- (void)dealloc {
	[fetch release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
	return [list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *StudyButtonCellIdentifier = @"StudyButtonCellIdentifier";
	UITableViewCell	*cell = [tableView dequeueReusableCellWithIdentifier: 
							 StudyButtonCellIdentifier];
	if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"StudyButtonCell" owner:self options:nil];
		cell = studyButtonCell;
		self.studyButtonCell = nil;
	}
	UILabel *label = (UILabel *)[cell viewWithTag:1];
	label.hidden = YES;
	UIImageView *image = (UIImageView *)[cell viewWithTag:5];
	image.hidden = YES;
	
	NSUInteger row = [indexPath row];
	NSUInteger count;
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Card" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	NSError *error = nil;
	
	switch (row) {
		case 0: {
			//Run count
			count = [managedObjectContext countForFetchRequest:request error:&error];
			if (error != nil) {
				NSLog(@"Error while fetching\n%@", ([error localizedDescription] != nil) ? [error localizedDescription]
					  : @"Unknown Error");
				exit(1);
			}
			[request release];
			label = (UILabel *)[cell viewWithTag:3];
			label.text = [NSString stringWithFormat:@"%d", count];
			label = (UILabel *)[cell viewWithTag:4];
			label.text = [NSString stringWithFormat:@"cards", count];
			break;
		}
		case 1: {
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			label = (UILabel *)[cell viewWithTag:3];
			label.hidden = YES;
			label = (UILabel *)[cell viewWithTag:4];
			label.hidden = YES;
			break;
		}
		case 2: {
			//Run count
			NSString *predicateString = [NSString stringWithFormat:@"favorite == 'Y'"];
			NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
			[request setPredicate:predicate];
			NSError *error = nil;
			count = [managedObjectContext countForFetchRequest:request error:&error];
			if (error != nil) {
				NSLog(@"Error while fetching\n%@", ([error localizedDescription] != nil) ? [error localizedDescription]
					  : @"Unknown Error");
				exit(1);
			}
			[request release];
			label = (UILabel *)[cell viewWithTag:3];
			label.text = [NSString stringWithFormat:@"%d", count];
			label = (UILabel *)[cell viewWithTag:4];
			if (count == 1)
				label.text = [NSString stringWithFormat:@"card", count];
			else
				label.text = [NSString stringWithFormat:@"cards", count];
			break;
		}
		case 3: {
			//Run count
			NSString *predicateString = [NSString stringWithFormat:@"formula == 'Y'"];
			NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
			[request setPredicate:predicate];
			NSError *error = nil;
			count = [managedObjectContext countForFetchRequest:request error:&error];
			if (error != nil) {
				NSLog(@"Error while fetching\n%@", ([error localizedDescription] != nil) ? [error localizedDescription]
					  : @"Unknown Error");
				exit(1);
			}
			[request release];
			label = (UILabel *)[cell viewWithTag:3];
			label.text = [NSString stringWithFormat:@"%d", count];
			label = (UILabel *)[cell viewWithTag:4];
			label.text = [NSString stringWithFormat:@"cards", count];
			break;
		}
		default:
			break;
	}
	NSString *rowString = [list objectAtIndex:row];
	cell.textLabel.text = [NSString stringWithFormat:@"%@", rowString];	
	label = cell.textLabel;
	label.backgroundColor = [UIColor clearColor];
	return cell;
}


#pragma mark -
#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Card" inManagedObjectContext:managedObjectContext];
	[fetchRequest setEntity:entity];
	self.fetch = fetchRequest;
	
	NSUInteger row = [indexPath row];
	switch (row) {
		case 0: {
			UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
																	 delegate:self
															cancelButtonTitle:nil
													   destructiveButtonTitle:nil
															otherButtonTitles:@"Shuffle", @"Sort", nil];
			[actionSheet showInView:self.view];
			[actionSheet release];
			break;
		}
		case 1: {
			BrowseTopicsController *nextController = [[BrowseTopicsController alloc] initWithStyle:UITableViewStyleGrouped];
			nextController.managedObjectContext = managedObjectContext;
			nextController.title = @"Topics";
			CFAidAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
			[delegate.navigationController pushViewController:nextController animated:YES];
			[nextController release];
			break;
		}
		case 2: {
			UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
			UILabel *label;
			label = (UILabel *)[cell viewWithTag:3];
			NSString *string = [label text];
			if ([string isEqualToString:@"0"] == YES) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Cards to Display."
																message:@"You haven't flagged any cards as favorites."
															   delegate:nil
													  cancelButtonTitle:@"Go flag some!"
													  otherButtonTitles:nil];
				[alert show];
				[alert release];	
				[tableView deselectRowAtIndexPath:indexPath animated:YES];
				
			}
			else {
				NSString *predicateString = [NSString stringWithFormat:@"favorite == 'Y'"];
				NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
				[fetch setPredicate:predicate];
				NSMutableArray *mutableFetchResults;
				NSError *error;
				mutableFetchResults = [[managedObjectContext executeFetchRequest:fetch error:&error] mutableCopy];
				if (mutableFetchResults == nil) {
					NSLog(@"Could not fetch objects");
				}
				srand(time(NULL));
				int numItems = [mutableFetchResults count];
				int randomIndex;
				for (int index = 0; index < numItems; index++) {
					randomIndex = rand() % numItems;
					[mutableFetchResults exchangeObjectAtIndex:index withObjectAtIndex:randomIndex];
				}
				//Go to next view
				BrowseCardsController *nextNavController = [[BrowseCardsController alloc] init];
				nextNavController.managedObjectContext = [self managedObjectContext];
				nextNavController.cardsArray = mutableFetchResults;
				CFAidAppDelegate *delegate = 
				[[UIApplication sharedApplication] delegate];
				[delegate.navigationController presentModalViewController:nextNavController animated:YES];
				[nextNavController release];
			}
			break;
		}
		case 3: {
			NSString *predicateString = [NSString stringWithFormat:@"formula == 'Y'"];
			NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
			[fetch setPredicate:predicate];
			NSMutableArray *mutableFetchResults;
			NSError *error;
			mutableFetchResults = [[managedObjectContext executeFetchRequest:fetch error:&error] mutableCopy];
			if (mutableFetchResults == nil) {
				NSLog(@"Could not fetch objects");
			}
			srand(time(NULL));
			int numItems = [mutableFetchResults count];
			int randomIndex;
			for (int index = 0; index < numItems; index++) {
				randomIndex = rand() % numItems;
				[mutableFetchResults exchangeObjectAtIndex:index withObjectAtIndex:randomIndex];
			}
			//Go to next view
			BrowseCardsController *nextNavController = [[BrowseCardsController alloc] init];
			nextNavController.managedObjectContext = [self managedObjectContext];
			nextNavController.cardsArray = mutableFetchResults;
			CFAidAppDelegate *delegate = 
			[[UIApplication sharedApplication] delegate];
			[delegate.navigationController presentModalViewController:nextNavController animated:YES];
			[nextNavController release];
			break;			
		}
		default:
			break;
	}
}
	
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	//The user clicked one of the Shuffle/Sort buttons
	NSMutableArray *mutableFetchResults;
	if (buttonIndex == 0) {
		NSError *error;
		mutableFetchResults = [[managedObjectContext executeFetchRequest:fetch error:&error] mutableCopy];
		if (mutableFetchResults == nil) {
			NSLog(@"Could not fetch objects");
		}
		srand(time(NULL));
		int numItems = [mutableFetchResults count];
		int randomIndex;
		for (int index = 0; index < numItems; index++) {
			randomIndex = rand() % numItems;
			[mutableFetchResults exchangeObjectAtIndex:index withObjectAtIndex:randomIndex];
		}
	}
	else {
		NSSortDescriptor *numberOrderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"numberOrder" ascending:YES];
		NSArray *sortDescriptors = [[[NSArray alloc] initWithObjects:numberOrderDescriptor, nil] autorelease];
		[fetch setSortDescriptors:sortDescriptors];
		[numberOrderDescriptor release];
		NSError *error;
		mutableFetchResults = [[managedObjectContext executeFetchRequest:fetch error:&error] mutableCopy];
		if (mutableFetchResults == nil) {
			NSLog(@"Could not fetch objects");
		}
	}	
	
	//Go to next view
	BrowseCardsController *nextNavController = [[BrowseCardsController alloc] init];
	nextNavController.managedObjectContext = [self managedObjectContext];
	nextNavController.cardsArray = mutableFetchResults;
	CFAidAppDelegate *delegate = 
	[[UIApplication sharedApplication] delegate];
	[delegate.navigationController presentModalViewController:nextNavController animated:YES];
	[nextNavController release];
}

@end

