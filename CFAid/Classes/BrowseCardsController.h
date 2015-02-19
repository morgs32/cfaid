//
//  BrowseCardsController.h
//  CFAid
//
//  Created by Morgan Intrator on 8/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "FlashCardsViewController.h"
#import "BrowseFrontViewController.h"
#import "BrowseBackViewController.h"

@class BrowseFrontViewController;
@class BrowseBackViewController;

@interface BrowseCardsController : FlashCardsViewController <BrowseFrontViewDelegate, BrowseBackViewDelegate> {
	BrowseFrontViewController *frontViewController;
	BrowseBackViewController *backViewController;
	NSInteger cardsInSession;
	NSInteger cardInArray;
}

@property (nonatomic, retain) BrowseFrontViewController *frontViewController;
@property (nonatomic, retain) BrowseBackViewController *backViewController;

@end