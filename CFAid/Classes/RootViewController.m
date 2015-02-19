//
//  RootViewController.m
//  CFAid
//
//  Created by Morgan Intrator on 8/3/09.
//  Copyright 2009 Pohleusis. All rights reserved.
//

#import	"CFAidAppDelegate.h"
#import "RootViewController.h"
#import "SecondLevelController.h"
#import "FlashCardsViewController.h"
#import "BrowseButtonController.h"
#import "StudyButtonController.h"
#import "SettingsViewController.h"
#import "SearchViewController.h"
#import "HowToController.h"
#import "AboutController.h"
#import "Card.h"

@implementation RootViewController
@synthesize managedObjectContext;
@synthesize controllers;

#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"CFAid";
	NSLog(@"MOC: %@", managedObjectContext);
	
	NSMutableArray *studyArray = [[NSMutableArray alloc] init];
	//Study Button
	StudyButtonController *studyButtonController = [[StudyButtonController alloc] 
	 initWithStyle:UITableViewStyleGrouped];
	studyButtonController.managedObjectContext = managedObjectContext;
	studyButtonController.buttonLabel = @"Study for Level 1";
	studyButtonController.title = @"Leitner #";
	studyButtonController.buttonImage = [UIImage imageNamed:@"StudyIcon.png"];
	[studyArray addObject:studyButtonController];
	[studyButtonController release];
	
	//Settings Button
	SettingsViewController *settingsViewController = 
	[[SettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
	settingsViewController.buttonLabel = @"Topic Settings";
	settingsViewController.title = @"Topic Settings";
	settingsViewController.buttonImage = [UIImage imageNamed:@"SettingsIcon.png"];
	[studyArray addObject:settingsViewController];
	[settingsViewController release];
	
	NSMutableArray *browseArray = [[NSMutableArray alloc] init];
	//Browse Button
	BrowseButtonController *browseButtonController = [[BrowseButtonController alloc] 
	 initWithStyle:UITableViewStyleGrouped];
	browseButtonController.managedObjectContext = managedObjectContext;
	browseButtonController.buttonLabel = @"Browse Level 1 Cards";
	browseButtonController.title = @"Browse";
	browseButtonController.buttonImage = [UIImage imageNamed:@"BrowseIcon.png"];
	[browseArray addObject:browseButtonController];
	[browseButtonController release];
	//Search Button
	SearchViewController *searchViewController = 
	[[SearchViewController alloc] init];
	searchViewController.managedObjectContext = managedObjectContext;
	searchViewController.buttonLabel = @"Search";
	searchViewController.title = @"Search";
	searchViewController.buttonImage = [UIImage imageNamed:@"SearchIcon.png"];
	[browseArray addObject:searchViewController];
	[searchViewController release];
	
	NSMutableArray *extraArray = [[NSMutableArray alloc] init];
	//How To Button
	HowToController *howToController = 
	[[HowToController alloc] init];
	howToController.buttonLabel = @"How To Study";
	howToController.title = @"How To Study";
	howToController.buttonImage = [UIImage imageNamed:@"InformationIcon.png"];
	[extraArray addObject:howToController];
	[howToController release];
	//About Button
	AboutController *aboutController = 
	[[AboutController alloc] init];
	aboutController.buttonLabel = @"About CFAid";
	aboutController.title = @"About CFAid";
	aboutController.buttonImage = [UIImage imageNamed:@"CFAidIcon32x32.png"];
	[extraArray addObject:aboutController];
	[aboutController release];

	NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:studyArray, browseArray, extraArray, nil];
	self.controllers = array;
	[array release];
	[studyArray release];
	[browseArray release];
	[extraArray release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
			interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
			interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark -
#pragma mark Table Data Source Methods
- (void)dealloc {
	[managedObjectContext release];
	[controllers release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [controllers count];
}

- (NSInteger)tableView:(UITableView *)tableView 
	numberOfRowsInSection:(NSInteger)section {
	NSArray *array = [controllers objectAtIndex:section];
	return [array count];
}

- (NSString *)tableView:(UITableView *)tableView 
titleForHeaderInSection: (NSInteger)section {
	NSString *titleSection;
	switch (section) {
		case 0: {
			titleSection = [NSString stringWithFormat:@"Study"];
			break;
		}
		case 1: {
			titleSection = [NSString stringWithFormat: @"Browse"];
			break;
		}
		case 2: {
			titleSection = [NSString stringWithFormat: @"Help"];
			break;
		}
		default:
			break;
	}
	return titleSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
	cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	static NSString *RootViewControllerCell = @"RootViewControllerCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: RootViewControllerCell];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero 
				reuseIdentifier: RootViewControllerCell] autorelease];
	}
	
	NSArray *array = [controllers objectAtIndex:indexPath.section];
	SecondLevelController *controller = [array objectAtIndex:indexPath.row];
	cell.textLabel.text = controller.buttonLabel;
	cell.imageView.image = controller.buttonImage;
	return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView
	didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSArray *array = [controllers objectAtIndex:indexPath.section];
	SecondLevelController *nextController = [array objectAtIndex:indexPath.row];;
	CFAidAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navigationController pushViewController:nextController animated:YES];
	
}

@end
