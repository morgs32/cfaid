//
//  FrontViewController.m
//  CFAid
//
//  Created by Morgan Intrator on 8/13/09.
//  Copyright 2009 Pohleusis. All rights reserved.
//

#import "FrontViewController.h"
#import "StudyCardsController.h"


@implementation FrontViewController
@synthesize card;
@synthesize labelReading;
@synthesize	labelTopic;
@synthesize labelNumber;
@synthesize labelCardText;
@synthesize labelStats;
@synthesize labelAnswer;
@synthesize imageFlag;
@synthesize correctOrIncorrect;
@synthesize cardsInSession;
@synthesize currentCardNumber;
@synthesize delegate;

#pragma mark -
#pragma mark View lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"Question";
	}
    return self;
}

//Setup the topic label
- (void)setUILabelTextWithVerticalAlignTop:(NSString *)theText {
	CGSize labelSize = CGSizeMake(174, 44);
	CGSize theStringSize = [theText sizeWithFont:labelTopic.font constrainedToSize:labelSize lineBreakMode:labelTopic.lineBreakMode];
	labelTopic.frame = CGRectMake(labelTopic.frame.origin.x, labelTopic.frame.origin.y, theStringSize.width, theStringSize.height);
	labelTopic.text = theText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
											   initWithTitle:@"End Session"
											   style:UIBarButtonItemStyleBordered
											   target:self
											   action:@selector(endSessionClicked:)] autorelease];	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	setUILabelTextWithVerticalAlignTop:[NSString stringWithFormat: @"%@", [card topic]];
	self.labelReading.text = [NSString stringWithFormat: @"Reading %@", [card reading]];
	NSString *newText = [NSString stringWithFormat:@"%@", [card front]];
	NSString *frontText = [newText stringByReplacingOccurrencesOfString:@"NLN" 
															withString: @"\n"
															   options: NSBackwardsSearch 
																 range: NSMakeRange(0, [newText length])];	
	self.labelCardText.text = frontText;
	self.labelStats.text = [NSString stringWithFormat: @"%@ of %@", currentCardNumber, cardsInSession];
	self.labelNumber.text = [NSString stringWithFormat: @"Card %@", [card numberOrder]];
	
	if ([[card favorite] isEqualToString:@"Y"] == YES) {
		imageFlag.hidden = NO;
	}
	if ([currentCardNumber intValue] > 1) {
		self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] 
												  initWithTitle:@"Previous"
												  style:UIBarButtonItemStyleBordered
												  target:self
												  action:@selector(previousCardButtonPressed:)] autorelease];	
	}
	else
		self.navigationItem.leftBarButtonItem = nil;

	if ([correctOrIncorrect isEqualToString:@"right"] == YES) {
		labelAnswer.hidden = NO;
		labelAnswer.backgroundColor = [UIColor greenColor];
		labelAnswer.text = @"CORRECT";
	}
	else if ([correctOrIncorrect isEqualToString:@"wrong"] == YES) {
		labelAnswer.hidden = NO;
		labelAnswer.backgroundColor = [UIColor redColor];
		labelAnswer.text = @"INCORRECT";
	}
	else
		labelAnswer.hidden = YES;
	if ([[card favorite] isEqualToString:@"N"] == YES)
		[imageFlag setHidden:YES];
	else
		[imageFlag setHidden:NO];
}	

- (void)endSessionClicked:(id)sender {
	[self.delegate endSession];
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

- (IBAction)seeAnswer:(id)sender {
	[self.delegate turnToBack];
}

- (void)previousCardButtonPressed:(id)sender {
	[self.delegate previousCard];
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
	[card release];
	[labelReading release];
	[labelTopic release];
	[labelNumber release];
	[labelCardText release];
	[labelStats release];
	[labelAnswer release];
	[imageFlag release];
	[correctOrIncorrect release];
	[cardsInSession release];
	[currentCardNumber release];
    [super dealloc];
}

@end
