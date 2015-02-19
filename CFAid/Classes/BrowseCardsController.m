//
//  BrowseCardsController.m
//  CFAid
//
//  Created by Morgan Intrator on 8/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FlashCardsViewController.h"
#import "BrowseCardsController.h"
#import "CFAidAppDelegate.h"
#import "BrowseFrontViewController.h"
#import "BrowseBackViewController.h"
#import "Card.h"


@implementation BrowseCardsController
@synthesize frontViewController;
@synthesize backViewController;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	cardInArray = 0;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:NO];
	BrowseFrontViewController *frontController = [[BrowseFrontViewController alloc] init];
	frontController.card = [cardsArray objectAtIndex:cardInArray];
	frontController.cardsInSession = [[NSNumber alloc] initWithInt:[cardsArray count]];
	frontController.delegate = self;
	frontController.currentCardNumber = [NSNumber numberWithInt:(cardInArray + 1)];
	self.frontViewController = frontController;
	[frontController release];
	[self pushViewController:frontController animated:NO];
}


- (void)turnToBack {
	BrowseBackViewController *backController = [[BrowseBackViewController alloc] init];
	backController.card = [cardsArray objectAtIndex:cardInArray];
	
	if (cardInArray == ([cardsArray count]-1))
		[backController lastCard];
	
	backController.delegate = self;
	self.backViewController = backController;
	[backController release];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:.50];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
	[self pushViewController:backViewController animated:NO];
	[UIView commitAnimations];
}

- (void)goBackToFront {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:.50];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	[self popViewControllerAnimated:NO];
	[UIView commitAnimations];
}

- (void)previousCard {
	cardInArray --;
	frontViewController.card = [cardsArray objectAtIndex:cardInArray];
	frontViewController.currentCardNumber = [NSNumber numberWithInt:(cardInArray + 1)];
	[frontViewController viewWillAppear:YES];
	
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.5];
	[animation setType:kCATransitionPush];
	[animation setSubtype:kCATransitionFromLeft];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[self.view layer] addAnimation:animation forKey:@"PreviousCard"];
	
}

- (void)endSession {
	NSError *error;
	if (![managedObjectContext save:&error]) {
		abort();
	}
	[self dismissModalViewControllerAnimated:YES];
}

- (void)nextCard {	
	cardInArray ++;
	frontViewController.card = [cardsArray objectAtIndex:cardInArray];
	frontViewController.currentCardNumber = [NSNumber numberWithInt:(cardInArray + 1)];
	[frontViewController viewDidAppear:YES];
	[self popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {
	[frontViewController release];
	[backViewController release];
    [super dealloc];
}

@end
