//
//  SettingsViewController.m
//  CFAid
//
//  Created by Morgan Intrator on 9/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"


@implementation SettingsViewController
@synthesize settingsButtonCell;

#pragma mark -
#pragma mark View lifecycle
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self.tableView reloadData];
}

- (void)viewDidLoad {
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

- (void)dealloc {
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
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

	static NSString *SettingsButtonCellIdentifier =	@"SettingsButtonCellIdentifier";
	
	UITableViewCell	*cell = [tableView dequeueReusableCellWithIdentifier: 
							 SettingsButtonCellIdentifier];
	if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"SettingsButtonCell" owner:self options:nil];
		cell = settingsButtonCell;
		self.settingsButtonCell = nil;
	}
	
	NSUInteger row = [indexPath row];
	
	NSString *rowString = [list objectAtIndex:row];
	UILabel *label;
	label = (UILabel *)[cell viewWithTag:1];
	label.text = [NSString stringWithFormat:@"%@", rowString];
	
	UISwitch *switchView = (UISwitch *)[cell viewWithTag:2];
	[switchView setOn:[[defaults stringForKey:rowString] boolValue] animated:NO];
	
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (IBAction)switchChanged:(UISwitch *)topicSwitch {
	// Find which cell this switch belongs to
	UIView *view = (UIView *)[topicSwitch superview];
	UITableViewCell *cell = (UITableViewCell *)[view superview];
	UITableView *table = (UITableView *)[cell superview];
	NSIndexPath *topicSwitchIndexPath = [table indexPathForCell:cell];
	NSUInteger row = [topicSwitchIndexPath row];
	NSString *rowString = [list objectAtIndex:row];
	NSLog(@"Switch flipped");
	NSUInteger newStateNum;
	if ([topicSwitch isOn]) {
		newStateNum = 1;
	} else {
		newStateNum = 0;
	}
	[[NSUserDefaults standardUserDefaults] setBool:newStateNum forKey:rowString];
}

@end
