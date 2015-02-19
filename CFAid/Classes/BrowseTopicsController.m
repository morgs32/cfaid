//
//  BrowseTopicController.m
//  CFAid
//
//  Created by Morgan Intrator on 11/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BrowseTopicsController.h"
#import "BrowseCardsController.h"
#import "CFAidAppDelegate.h"


@implementation BrowseTopicsController
@synthesize studyButtonCell;
@synthesize fetch;

#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
	list = [[NSArray alloc] initWithObjects:@"Ethical and Professional Standards", @"Quantitative Methods", @"Economics", @"Financial Statement Analysis",
			@"Corporate Finance", @"Portfolio Management", @"Equity Investments", @"Fixed Income Investments",
			@"Derivative Investments", @"Alternative Investments", nil];
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

- (void)viewDidUnload {
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
	
	NSString *topicString = [list objectAtIndex:row];

	NSString *predicateString = [NSString stringWithFormat:@"topic == '%@'", topicString];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
	[request setPredicate:predicate];
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
	
	if (row == 0)
		topicString = [NSString stringWithFormat:@"Ethical and Professional \nStandards"];
	
	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:16.0];
	cell.textLabel.frame.size.width == 200;
	cell.textLabel.numberOfLines = 2;
	cell.textLabel.text = topicString;
	
	return cell;
}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSUInteger row = [indexPath row];
	NSString *topicString = [list objectAtIndex:row];
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Card" inManagedObjectContext:managedObjectContext];
	[fetchRequest setEntity:entity];	
	NSString *predicateString = [NSString stringWithFormat:@"topic == '%@'", topicString];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
	[fetchRequest setPredicate:predicate];
	self.fetch = fetchRequest;
	[fetchRequest release];
	
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
															 delegate:self
													cancelButtonTitle:nil
											   destructiveButtonTitle:nil
													otherButtonTitles:@"Shuffle", @"Sort", nil];
	[actionSheet showInView:self.view];
	[actionSheet release];
	
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
