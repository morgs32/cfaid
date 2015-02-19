//
//  GraphViewController.m
//  CFAid
//
//  Created by Morgan Intrator on 11/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"
#import "GraphView.h"


@implementation GraphViewController
@synthesize right;
@synthesize wrong;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    return self;
}

- (void)viewDidLoad {
	self.title = @"Results";
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
												 name:UIDeviceOrientationDidChangeNotification object:nil];	
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
											   initWithTitle:@"End Session"
											   style:UIBarButtonItemStyleBordered
											   target:self
											   action:@selector(endSessionClicked:)] autorelease];	
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:YES];	
	GraphView *graphView = [[GraphView alloc] initWithFrame:CGRectMake(0, 0, 240, 240)];
	graphView.right = right;
	graphView.wrong = wrong;
	graphView.opaque = NO;
	graphView.tag = 1;
	[self.view addSubview:graphView];
	[graphView release];
	[self setupView];
}

- (void)setupView {
	UIView *graphView = (UIView *)[self.view viewWithTag:1];
	UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
	CGFloat curYLoc;
	UILabel *label;
    if (UIDeviceOrientationIsLandscape(deviceOrientation)) {
		graphView.center = CGPointMake(130.0f, (self.view.frame.size.height/2 -3));
		curYLoc = 122.5f;
		for (int i=2; i<=4; i++) {
			label = (UILabel *)[self.view viewWithTag:i];
			label.center = CGPointMake(310.0f, curYLoc);
			label.font = [UIFont systemFontOfSize:18.0];
			curYLoc = curYLoc + 23.0f;
		}
		curYLoc = 122.5f;
		for (int i=5; i<=7; i++) {
			label = (UILabel *)[self.view viewWithTag:i];
			label.center = CGPointMake(447.0f, curYLoc);
			label.font = [UIFont systemFontOfSize:18.0];
			curYLoc = curYLoc + 23.0f;
		}
	}
	else {
		graphView.center = CGPointMake(self.view.center.x, 130.0f);
		curYLoc = 272.0f;
		for (int i=2; i<=4; i++) {
			label = (UILabel *)[self.view viewWithTag:i];
			label.frame = CGRectMake(20, curYLoc, 196, 30);
			label.font = [UIFont boldSystemFontOfSize:24.0];
			curYLoc = curYLoc + 33.0f;
		}
		curYLoc = 272.0f;
		for (int i=5; i<=7; i++) {
			label = (UILabel *)[self.view viewWithTag:i];
			label.frame = CGRectMake(224, curYLoc, 62, 30);
			label.font = [UIFont boldSystemFontOfSize:24.0];
			curYLoc = curYLoc + 33.0f;
		}
	}
	//Setup statistics
	label = (UILabel *)[self.view viewWithTag:5];
	float percentageRight = 100.0f * ((float)right / ((float)right + (float)wrong));
	if (((float)right + (float)wrong) == 0.0f)
		label.text = [NSString stringWithFormat:@"-"];
	else
		label.text = [NSString stringWithFormat:@"%.0f%%", percentageRight];
	label = (UILabel *)[self.view viewWithTag:6];
	label.text = [NSString stringWithFormat:@"%d", right];
	label = (UILabel *)[self.view viewWithTag:7];
	label.text = [NSString stringWithFormat:@"%d", wrong];

}

- (void)endSessionClicked:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
			interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
			interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)orientationChanged:(NSNotification *)notification
{
    [self performSelector:@selector(setupView) withObject:nil afterDelay:0];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [super dealloc];
}


@end
