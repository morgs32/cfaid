//
//  FlashCards.m
//  CFAid
//
//  Created by Morgan Intrator on 8/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FlashCardsViewController.h"


@implementation FlashCardsViewController
@synthesize managedObjectContext;
@synthesize card;
@synthesize leitnerBoxNumber;
@synthesize cardsArray;


- (void)viewDidUnload {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	[managedObjectContext release];
	[card release];
	[leitnerBoxNumber release];
	[cardsArray release];
    [super dealloc];
}

@end
