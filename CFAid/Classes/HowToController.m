//
//  HowToController.m
//  CFAid
//
//  Created by Morgan Intrator on 11/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HowToController.h"


@implementation HowToController
@synthesize buttonImage;
@synthesize buttonLabel;
@synthesize scrollView;

#pragma mark -
#pragma mark View lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
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
	CGFloat curYLoc = (10.0f);
	//Setup the first label
	label = (UILabel *)[scrollView viewWithTag:0];
	CGFloat labelWidth = label.frame.size.width;
	NSString *labelText = label.text;
	CGSize theLabelSize = [labelText sizeWithFont:label.font constrainedToSize:CGSizeMake(labelWidth, 2000) 
									lineBreakMode:UILineBreakModeWordWrap];
	label.frame = CGRectMake(label.frame.origin.x, curYLoc, 
							 labelWidth, theLabelSize.height);
	curYLoc = (curYLoc + theLabelSize.height + 10.0f);
	//Setup the second label
	label = (UILabel *)[scrollView viewWithTag:1];
	label.frame = CGRectMake(label.frame.origin.x, curYLoc, 
							 label.frame.size.width, label.frame.size.height);
	curYLoc = (curYLoc + label.frame.size.height + 5.0f);
	//Setup the image
	UIImageView *imageView = (UIImageView *)[self.view viewWithTag:2];
	imageView.frame = CGRectMake(imageView.frame.origin.x, curYLoc, 
								 imageView.frame.size.width, imageView.frame.size.height);
	curYLoc = (curYLoc + imageView.frame.size.height + 5.0f);
	//Setup the third label
	label = (UILabel *)[self.view viewWithTag:3];
	label.frame = CGRectMake(label.frame.origin.x, curYLoc, 
							 label.frame.size.width, label.frame.size.height);
	curYLoc = (curYLoc + label.frame.size.height + 10.0f);
	//Setup the fourth label
	label = (UILabel *)[self.view viewWithTag:4];
	labelText = label.text;
	theLabelSize = [labelText sizeWithFont:label.font constrainedToSize:CGSizeMake(labelWidth, 2000) 
									lineBreakMode:UILineBreakModeWordWrap];
	label.frame = CGRectMake(label.frame.origin.x, curYLoc, 
							 theLabelSize.width, theLabelSize.height);
	curYLoc = (curYLoc + theLabelSize.height + 10.0f);
	//Setup the last label
	label = (UILabel *)[self.view viewWithTag:5];
	labelText = label.text;
	theLabelSize = [labelText sizeWithFont:label.font constrainedToSize:CGSizeMake(labelWidth, 2000) 
							 lineBreakMode:UILineBreakModeWordWrap];
	label.frame = CGRectMake(label.frame.origin.x, curYLoc, 
							 theLabelSize.width, theLabelSize.height);
	curYLoc = (curYLoc + theLabelSize.height + 30.0f);
	
	[scrollView setContentSize:CGSizeMake(labelWidth + 12, curYLoc)];
}

- (void)orientationChanged:(NSNotification *)notification
{
    // We must add a delay here, otherwise we'll swap in the new view
    // too quickly and we'll get an animation glitch
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
    [buttonImage release];
	[buttonLabel release];
	[scrollView release];
    [super dealloc];
}


@end
