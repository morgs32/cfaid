//
//  StudyButtonController.m
//  CFAid
//
//  Created by Morgan Intrator on 8/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "StudyButtonController.h"
#import "CFAidAppDelegate.h"
#import "RootViewController.h"
#import "FlashCardsViewController.h"
#import "StudyCardsController.h"
#import "Card.h"



@implementation StudyButtonController
@synthesize studyButtonCell;
@synthesize boxCounts;
@synthesize topics;
@synthesize managedObjectModel;
@synthesize fetch;
@synthesize titleNotes;

#pragma mark -
#pragma mark View lifecycle
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
			interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
			interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.topics = [NSMutableArray arrayWithObjects:@"Ethical and Professional Standards", @"Quantitative Methods", @"Economics", @"Financial Statement Analysis",
			@"Corporate Finance", @"Portfolio Management", @"Equity Investments", @"Fixed Income Investments",
			@"Derivative Investments", @"Alternative Investments", nil];
	NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"(Study Constantly)",
							 @" ", @"(Study Occasionally)", @" ", @"(Study Seldomly)", nil];
	self.list = array;
	[array release];
	
	managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
	if (managedObjectModel == nil) {
		NSLog(@"Could not find MOM");
	}	
}

- (NSInteger)runFetch:(NSInteger)tableBoxNumber {
	NSNumber *boxNumber = [[NSNumber alloc] init];
	boxNumber = [NSNumber numberWithInt:tableBoxNumber];
	
	//Perform the countForFetchRequest
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Card" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	NSString *predicateString = [NSString stringWithFormat:@"leitnerBox == %@", boxNumber];
	NSNumber *studyOrNot;
	NSString *appendString;
	NSString *topicString;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	for (int i=0; i < 10; i++) {
		topicString = [topics objectAtIndex:i];
		studyOrNot = [defaults objectForKey:topicString];
		if ([studyOrNot intValue] == 0) {
			appendString = [predicateString stringByAppendingString:[NSString stringWithFormat:@" AND topic != '%@'", topicString]];
			predicateString = appendString;
		}
	}
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
	[request setPredicate:predicate];
	NSError *error = nil;
	NSUInteger count = [managedObjectContext countForFetchRequest:request error:&error];
		if (error != nil)
	{
		NSLog(@"Error while fetching\n%@", ([error localizedDescription] != nil) ? [error localizedDescription]
			  : @"Unknown Error");
		exit(1);
	}
	return count;
	[request release];
	[boxNumber release];
}

#pragma mark -
#pragma mark Memory management
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
}

- (void)dealloc {
	[boxCounts release];
	[topics release];
	[managedObjectModel release];
	[fetch release];
	[titleNotes release];
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
		
	static NSString *StudyButtonCellIdentifier = 
	@"StudyButtonCellIdentifier";
	
	UITableViewCell	*cell = [tableView dequeueReusableCellWithIdentifier: 
							 StudyButtonCellIdentifier];
	if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"StudyButtonCell" owner:self options:nil];
		cell = studyButtonCell;
		self.studyButtonCell = nil;
	}
	row = [indexPath row];
	switch (row) {
		case 0: {
			NSString *rowString = [list objectAtIndex:row];
			UILabel *label;
			label = (UILabel *)[cell viewWithTag:1];
			label.text = [NSString stringWithFormat:@"%@", rowString];
			NSNumber *rowNumber = [NSNumber numberWithInt:[self runFetch:1]];
			label = (UILabel *)[cell viewWithTag:3];
			label.text = [NSString stringWithFormat:@"%@", rowNumber];
			label = (UILabel *)[cell viewWithTag:4];
			if ([rowNumber intValue] == 1)
				label.text = [NSString stringWithFormat:@"card"];
			else
				label.text = [NSString stringWithFormat:@"cards"];
			UIImageView *imageView;
			imageView = (UIImageView *)[cell viewWithTag:5];
			imageView.image = [UIImage imageNamed:@"Number1.png"];
			break;
		}
		case 1: {
			NSString *rowString = [list objectAtIndex:row];
			UILabel *label;
			label = (UILabel *)[cell viewWithTag:1];
			label.text = [NSString stringWithFormat:@"%@", rowString];
			NSNumber *rowNumber = [NSNumber numberWithInt:[self runFetch:2]];
			label = (UILabel *)[cell viewWithTag:3];
			label.text = [NSString stringWithFormat:@"%@", rowNumber];
			label = (UILabel *)[cell viewWithTag:4];
			if ([rowNumber intValue] == 1)
				label.text = [NSString stringWithFormat:@"card"];
			else
				label.text = [NSString stringWithFormat:@"cards"];
			UIImageView *imageView;
			imageView = (UIImageView *)[cell viewWithTag:5];
			imageView.image = [UIImage imageNamed:@"Number2.png"];
			break;
		}
		case 2: {
			NSString *rowString = [list objectAtIndex:row];
			UILabel *label;
			label = (UILabel *)[cell viewWithTag:1];
			label.text = [NSString stringWithFormat:@"%@", rowString];
			NSNumber *rowNumber = [NSNumber numberWithInt:[self runFetch:3]];
			label = (UILabel *)[cell viewWithTag:3];
			label.text = [NSString stringWithFormat:@"%@", rowNumber];
			label = (UILabel *)[cell viewWithTag:4];
			if ([rowNumber intValue] == 1)
				label.text = [NSString stringWithFormat:@"card"];
			else
				label.text = [NSString stringWithFormat:@"cards"];
			UIImageView *imageView;
			imageView = (UIImageView *)[cell viewWithTag:5];
			imageView.image = [UIImage imageNamed:@"Number3.png"];
			break;
		}
		case 3: {
			NSString *rowString = [list objectAtIndex:row];
			UILabel *label;
			label = (UILabel *)[cell viewWithTag:1];
			label.text = [NSString stringWithFormat:@"%@", rowString];
			NSNumber *rowNumber = [NSNumber numberWithInt:[self runFetch:4]];
			label = (UILabel *)[cell viewWithTag:3];
			label.text = [NSString stringWithFormat:@"%@", rowNumber];
			label = (UILabel *)[cell viewWithTag:4];
			if ([rowNumber intValue] == 1)
				label.text = [NSString stringWithFormat:@"card"];
			else
				label.text = [NSString stringWithFormat:@"cards"];
			UIImageView *imageView;
			imageView = (UIImageView *)[cell viewWithTag:5];
			imageView.image = [UIImage imageNamed:@"Number4.png"];
			break;
		}
		case 4: {
			NSString *rowString = [list objectAtIndex:row];
			UILabel *label;
			label = (UILabel *)[cell viewWithTag:1];
			label.text = [NSString stringWithFormat:@"%@", rowString];
			NSNumber *rowNumber = [NSNumber numberWithInt:[self runFetch:5]];
			label = (UILabel *)[cell viewWithTag:3];
			label.text = [NSString stringWithFormat:@"%@", rowNumber];
			label = (UILabel *)[cell viewWithTag:4];
			if ([rowNumber intValue] == 1)
				label.text = [NSString stringWithFormat:@"card"];
			else
				label.text = [NSString stringWithFormat:@"cards"];
			UIImageView *imageView;
			imageView = (UIImageView *)[cell viewWithTag:5];
			imageView.image = [UIImage imageNamed:@"Number5.png"];
			break;
		}
		default:
			break;
	}
	return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView 
	didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	row = [indexPath row];
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	UILabel *label;
	label = (UILabel *)[cell viewWithTag:3];
	NSString *string = [label text];
	if ([string isEqualToString:@"0"] == YES) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Cards"
														message:@"There are no cards in this box because\n1)You have not answered enough cards correctly.\n2)You have not turned on the appropriate study topics. Go to Topic Settings to turn on the topics you are prepared to study."
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
	[alert show];
	[alert release];	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	}
	else {
		//Run fetch
		int boxNumber = row + 1;
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"Card" inManagedObjectContext:managedObjectContext];
		[fetchRequest setEntity:entity];
		NSNumber *rowNumber = [NSNumber numberWithInt:boxNumber];
		NSString *predicateString = [NSString stringWithFormat:@"leitnerBox == %@", rowNumber];
		NSNumber *studyOrNot;
		NSString *appendString;
		NSString *topicString;
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		for (int i=0; i < 10; i++) {
			topicString = [topics objectAtIndex:i];
			studyOrNot = [defaults objectForKey:topicString];
			if ([studyOrNot intValue] == 0) {
				appendString = [predicateString stringByAppendingString:[NSString stringWithFormat:@" AND topic != '%@'", topicString]];
				predicateString = appendString;
			}
		}
		NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
		[fetchRequest setPredicate:predicate];
		
		//Use an actionSheet to sort or shuffle
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
																 delegate:self
														cancelButtonTitle:nil
												   destructiveButtonTitle:nil
														otherButtonTitles:@"Shuffle", @"Sort", nil];
		[actionSheet showInView:self.view];
		[actionSheet release];
		self.fetch = fetchRequest;
		[fetchRequest release];
		
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
	StudyCardsController *nextNavController = [[StudyCardsController alloc] init];
	nextNavController.leitnerBoxNumber = [NSNumber numberWithInt:(row + 1)];
	nextNavController.managedObjectContext = [self managedObjectContext];
	nextNavController.cardsArray = mutableFetchResults;
	CFAidAppDelegate *delegate = 
	[[UIApplication sharedApplication] delegate];
	[delegate.navigationController presentModalViewController:nextNavController animated:YES];
	[nextNavController release];
}
	
@end

