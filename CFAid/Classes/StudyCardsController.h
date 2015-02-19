//
//  StudyCardsController.h
//  CFAid
//
//  Created by Morgan Intrator on 8/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "FlashCardsViewController.h"
#import "FrontViewController.h"
#import "BackViewController.h"
#import "GraphViewController.h"

@class FrontViewController;
@class BackViewController;

@interface StudyCardsController : FlashCardsViewController <FrontViewDelegate, BackViewDelegate> {
	FrontViewController *frontViewController;
	BackViewController *backViewController;
	NSInteger cardsInSession;
	NSInteger cardInArray;
	NSMutableArray *rightOrWrong;
	NSMutableArray *rightCards;
	NSMutableArray *wrongCards;
	NSNumber *newBoxNumber;
}

@property (nonatomic, retain) FrontViewController *frontViewController;
@property (nonatomic, retain) BackViewController *backViewController;
@property (nonatomic, retain) NSMutableArray *rightOrWrong;
@property (nonatomic, retain) NSMutableArray *rightCards;
@property (nonatomic, retain) NSMutableArray *wrongCards;



@end
