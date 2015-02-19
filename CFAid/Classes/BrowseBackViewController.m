//
//  BackViewController.m
//  CFAid
//
//  Created by Morgan Intrator on 8/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BrowseBackViewController.h"
#import "CFAidAppDelegate.h"

@implementation BrowseBackViewController
@synthesize scrollView;
@synthesize imageFlag;
@synthesize labelCardNumber;
@synthesize card;
@synthesize delegate;

#pragma mark -
#pragma mark View lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"Answer";
	}
    return self;
}

- (void)lastCard {
	UISegmentedControl *button = (UISegmentedControl *)[self.view viewWithTag:1];
	button.hidden = YES;
}

- (IBAction)segmentAction:(id)sender {
	[self nextCardButtonPressed];
}

- (void)nextCardButtonPressed {
	[self.delegate nextCard];
}

- (void)favoriteButtonPressed:(id)sender {
	if ([[card favorite] isEqualToString:@"N"] == YES) {
		[imageFlag setHidden:NO];
		[card setFavorite:@"Y"];
	}
	else {
		[imageFlag setHidden:YES];
		[card setFavorite:@"N"];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	[self setupView];
	if ([[card favorite] isEqualToString:@"N"] == YES)
		[imageFlag setHidden:YES];
	else
		[imageFlag setHidden:NO];
	labelCardNumber.text = [NSString stringWithFormat:@"Card %@", [card numberOrder]];
}

- (void)viewDidLoad {
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
												 name:UIDeviceOrientationDidChangeNotification object:nil];	
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
											   initWithTitle:@"Quit"
											   style:UIBarButtonItemStyleBordered
											   target:self
											   action:@selector(endSessionClicked:)] autorelease];
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] 
											  initWithTitle:@"Question"
											  style:UIBarButtonItemStyleBordered
											  target:self
											  action:@selector(backButtonPressed:)] autorelease];
	self.navigationItem.leftBarButtonItem.width =  self.navigationItem.rightBarButtonItem.width;
}

- (void)setupView {
	NSString *newText = [NSString stringWithFormat:@"%@", [card back]];
	NSString *backText = [newText stringByReplacingOccurrencesOfString:@"NLN" 
															withString: @"\n"
															   options: NSBackwardsSearch 
																 range: NSMakeRange(0, [newText length])];
	UILabel *label = (UILabel *)[self.view viewWithTag:2];
	label.frame = CGRectMake(10.0f, 20.0f, (scrollView.frame.size.width - 20.0f), (scrollView.frame.size.height - 40.0f));
	CGSize theLabelSize = [backText sizeWithFont:label.font 
							   constrainedToSize:CGSizeMake(label.frame.size.width, 2000) lineBreakMode:UILineBreakModeWordWrap];
		
	NSString *shouldDisplayImage = [NSString stringWithFormat:@"%@", [card formula]];
	if ([shouldDisplayImage isEqualToString:@"Y"]) {
		NSString *imageName = [NSString stringWithFormat:@"%@.png", [card numberID]];
		UIImage *image = [UIImage imageNamed:imageName];
		if ((theLabelSize.height + image.size.height) > label.frame.size.height) {
			label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, theLabelSize.height);
			CGFloat curYLoc = (label.frame.origin.y + label.frame.size.height + 10.0f);
			UIImageView *formulaImageView = (UIImageView *)[self.view viewWithTag:3];
			[formulaImageView setHidden:NO];
			formulaImageView.image = image;
			CGRect newRect = [formulaImageView frame];
			newRect.size.height = image.size.height;
			newRect.origin.y = curYLoc;
			[formulaImageView setFrame:newRect];
			curYLoc += (newRect.size.height + 17.0f);
			[scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, curYLoc)];	
		}
		else {
			label.frame = CGRectMake(label.frame.origin.x, (10.0f + (label.frame.size.height/2) - ((theLabelSize.height + image.size.height)/2)), label.frame.size.width, theLabelSize.height);
			CGFloat curYLoc = (label.frame.origin.y + label.frame.size.height + 10.0f);
			UIImageView *formulaImageView = (UIImageView *)[self.view viewWithTag:3];
			[formulaImageView setHidden:NO];
			formulaImageView.image = image;
			CGRect newRect = [formulaImageView frame];
			newRect.size.height = image.size.height;
			newRect.origin.y = curYLoc;
			[formulaImageView setFrame:newRect];
			curYLoc += (newRect.size.height + 17.0f);
			[scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height)];
		}
	}
	else {
		if (theLabelSize.height > label.frame.size.height) {
			label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, theLabelSize.height);
			[scrollView setContentSize:CGSizeMake(label.frame.size.width + 20, theLabelSize.height + 47)];
			NSLog(@"Label size is: %f by %f", theLabelSize.width, theLabelSize.height);
			NSLog(@"ScrollView size is: %f by %f", scrollView.frame.size.width, scrollView.frame.size.height);
			
		}
		else {
			[scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height)];
			NSLog(@"Label widths are: %f by %f", theLabelSize.width, label.frame.size.width);
			NSLog(@"Label heights are: %f by %f", theLabelSize.height, label.frame.size.height);
		}
	}
	label.text = backText;	
	label = (UILabel *)[self.view viewWithTag:4];
	label.frame = CGRectMake(label.frame.origin.x, (scrollView.contentSize.height - 13.0f), label.frame.size.width, label.frame.size.height);
	NSLog(@"The frame is: %f, %f, %f, %f", label.frame.origin.x, label.frame.origin.y, label.frame.size.width, label.frame.size.height);
}

- (void)endSessionClicked:(id)sender {
	[self.delegate endSession];
}

- (void)backButtonPressed:(id)sender {
	[self.delegate goBackToFront];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
			interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
			interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)orientationChanged:(NSNotification *)notification
{
    // We must add a delay here, otherwise we'll swap in the new view
    // too quickly and we'll get an animation glitch
    [self performSelector:@selector(setupView) withObject:nil afterDelay:0];
}

#pragma mark -
#pragma mark Memory management
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
	[labelCardNumber release];
	[imageFlag release];
	[scrollView release];
	[card release];
	[super dealloc];
}


@end