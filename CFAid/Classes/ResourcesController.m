//
//  ResourcesController.m
//  CFAid
//
//  Created by Morgan Intrator on 12/9/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ResourcesController.h"


@implementation ResourcesController
@synthesize scrollView;

#pragma mark -
#pragma mark View lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
												 name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
	[self setupView];
}

- (void)setupView {
	UILabel *label;
	CGFloat curYLoc = 10.0f;
	//Setup the disclaimers header label
	label = (UILabel *)[scrollView viewWithTag:13];
	label.frame = CGRectMake(label.frame.origin.x, curYLoc, 
							 label.frame.size.width, label.frame.size.height);
	curYLoc += (label.frame.size.height + 10.0f);
	//Setup the second label
	label = (UILabel *)[scrollView viewWithTag:1];
	CGFloat labelWidth = label.frame.size.width;
	NSString *labelText = label.text;
	CGSize theLabelSize = [labelText sizeWithFont:label.font constrainedToSize:CGSizeMake(labelWidth, 200) 
									lineBreakMode:UILineBreakModeWordWrap];
	label.frame = CGRectMake(label.frame.origin.x, curYLoc, 
							 labelWidth, theLabelSize.height);
	curYLoc += (theLabelSize.height + 5.0f);

	//Setup the rest of the disclaimer labels
	for (int i = 2; i < 5; i++) {
		label = (UILabel *)[scrollView viewWithTag:i];
		labelText = label.text;
		theLabelSize = [labelText sizeWithFont:label.font constrainedToSize:CGSizeMake(labelWidth, 200) 
								 lineBreakMode:UILineBreakModeWordWrap];
		label.frame = CGRectMake(label.frame.origin.x, curYLoc, 
								 labelWidth, theLabelSize.height);
		curYLoc += (theLabelSize.height + 5.0f);
	}
	//Setup the Resource header label
	curYLoc += 5.0f;
	label = (UILabel *)[scrollView viewWithTag:5];
	label.frame = CGRectMake(label.frame.origin.x, curYLoc, 
								 labelWidth, label.frame.size.height);
	curYLoc += (label.frame.size.height + 10.0f);
	//Setup the rest of the resource lables
	for (int i = 6; i <= 12; i++) {
		label = (UILabel *)[scrollView viewWithTag:i];
		labelText = label.text;
		theLabelSize = [labelText sizeWithFont:label.font constrainedToSize:CGSizeMake(labelWidth, 200) 
								 lineBreakMode:UILineBreakModeWordWrap];
		label.frame = CGRectMake(label.frame.origin.x, curYLoc, 
								 labelWidth, theLabelSize.height);
		curYLoc += (theLabelSize.height + 5.0f);
	}
	curYLoc += 25.0f;
	[scrollView setContentSize:CGSizeMake(labelWidth + 12, curYLoc)];
}	

- (void)orientationChanged:(NSNotification *)notification
{
    [self performSelector:@selector(setupView) withObject:nil afterDelay:0];
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
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [scrollView release];
    [super dealloc];
}

@end
