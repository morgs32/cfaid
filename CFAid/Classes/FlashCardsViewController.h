//
//  FlashCards.h
//  CFAid
//
//  Created by Morgan Intrator on 8/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@class Card;


@interface FlashCardsViewController : UINavigationController  {
	NSManagedObjectContext *managedObjectContext;
	Card *card;
	NSNumber *leitnerBoxNumber;
	NSMutableArray *cardsArray;
	
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) Card *card;
@property (nonatomic, retain) NSNumber *leitnerBoxNumber;
@property (nonatomic, retain) NSMutableArray *cardsArray;


@end
