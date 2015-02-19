//
//  StudyCardsController.m
//  CFAid
//
//  Created by Morgan Intrator on 8/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FlashCardsViewController.h"
#import "StudyCardsController.h"
#import "CFAidAppDelegate.h"
#import "FrontViewController.h"
#import "BackViewController.h"
#import "GraphViewController.h"


@implementation StudyCardsController
@synthesize frontViewController;
@synthesize backViewController;
@synthesize rightOrWrong;
@synthesize rightCards;
@synthesize wrongCards;

#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad {
	self.title = @"Leitner #";

	cardInArray = 0;
	NSMutableArray *array1 = [[NSMutableArray alloc] init];
	self.rightOrWrong = array1;
	[array1 release];
	NSMutableArray *array2 = [[NSMutableArray alloc] init];
	self.rightCards = array2;
	[array2 release];
	NSMutableArray *array3 = [[NSMutableArray alloc] init];
	self.wrongCards = array3;
	[array3 release];
	
	FrontViewController *frontController = [[FrontViewController alloc] init];
	frontController.card = [cardsArray objectAtIndex:cardInArray];
	frontController.cardsInSession = [NSNumber numberWithInt:[cardsArray count]];
	frontController.delegate = self;
	frontController.currentCardNumber = [NSNumber numberWithInt:(cardInArray + 1)];
	self.frontViewController = frontController;
	[frontController release];
	
	[self pushViewController:frontController animated:YES];
}

- (void)turnToBack {
	BackViewController *backController = [[BackViewController alloc] init];
	backController.card = [cardsArray objectAtIndex:cardInArray];
	backController.title = @"Answer";
	backController.delegate = self;
	if (cardInArray < [rightOrWrong count]) {
		backController.correctOrIncorrect = [NSString stringWithFormat:[rightOrWrong objectAtIndex:cardInArray]];
	}
	else 
		backController.correctOrIncorrect = nil;
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

- (void)endSession {
	newBoxNumber = [NSNumber numberWithInt:[leitnerBoxNumber intValue] + 1];
	NSError *error;
	if ([leitnerBoxNumber intValue] < 5) {
		for (id obj in rightCards)
			[obj setLeitnerBox:newBoxNumber];
		if (![managedObjectContext save:&error]) {
			abort();
		}
	}
	newBoxNumber = [NSNumber numberWithInt:1]; 
	for (id obj in wrongCards) {
		[obj setLeitnerBox:newBoxNumber];
		if (![managedObjectContext save:&error]) {
			abort();
		}
	}
	GraphViewController *graphViewController = [[GraphViewController alloc] init];
	graphViewController.right = [rightCards count];
	graphViewController.wrong = [wrongCards count];
	[self pushViewController:graphViewController animated:NO];
	[graphViewController release];
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.5];
	[animation setType:kCATransitionPush];
	[animation setSubtype:kCATransitionFromBottom];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[self.view layer] addAnimation:animation forKey:@"End Session"];
}

- (void)previousCard {
	cardInArray --;
	frontViewController.card = [cardsArray objectAtIndex:cardInArray];
	frontViewController.currentCardNumber = [NSNumber numberWithInt:(cardInArray + 1)];
	frontViewController.correctOrIncorrect = [NSString stringWithFormat:[rightOrWrong objectAtIndex:cardInArray]];
	[frontViewController viewWillAppear:YES];
	
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.5];
	[animation setType:kCATransitionPush];
	[animation setSubtype:kCATransitionFromLeft];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[self.view layer] addAnimation:animation forKey:@"PreviousCard"];
}

- (void)nextCard:(NSString *)string {
	if (cardInArray < [rightOrWrong count]) {
		[rightOrWrong replaceObjectAtIndex:cardInArray withObject:string];
		if ([string isEqualToString:@"right"]) {
			[wrongCards removeObject:[cardsArray objectAtIndex:cardInArray]];
			[rightCards addObject:[cardsArray objectAtIndex:cardInArray]];
		}
		else {
			[rightCards removeObject:[cardsArray objectAtIndex:cardInArray]];
			[wrongCards addObject:[cardsArray objectAtIndex:cardInArray]];
		}
	}
	else {
		[rightOrWrong addObject:string];
		if ([string isEqualToString:@"right"])
			[rightCards addObject:[cardsArray objectAtIndex:cardInArray]];
		else
			[wrongCards addObject:[cardsArray objectAtIndex:cardInArray]];
	}
	
	if (cardInArray == ([cardsArray count]-1))
		[self endSession];
	else {
		cardInArray ++;
		frontViewController.card = [cardsArray objectAtIndex:cardInArray];
		frontViewController.currentCardNumber = [NSNumber numberWithInt:(cardInArray + 1)];
		if (cardInArray < [rightOrWrong count]) {
			frontViewController.correctOrIncorrect = [NSString stringWithFormat:[rightOrWrong objectAtIndex:cardInArray]];
		}
		else 
			frontViewController.correctOrIncorrect = nil;
		[self popViewControllerAnimated:YES];
	}
}

#pragma mark -
#pragma mark Memory management
- (void)dealloc {
	[frontViewController release];
	[backViewController release];
	[rightOrWrong release];
	[rightCards release];
	[wrongCards release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release anything that's not essential, such as cached data
}

@end
