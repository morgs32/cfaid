//
//  FrontViewController.h
//  CFAid
//
//  Created by Morgan Intrator on 8/13/09.
//  Copyright 2009 Pohleusis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"


@protocol BrowseFrontViewDelegate;


@interface BrowseFrontViewController : UIViewController {
	Card *card;
	IBOutlet	UILabel	*labelTopic;
	IBOutlet	UILabel *labelReading;
	IBOutlet	UILabel	*labelNumber;
	IBOutlet	UILabel	*labelCardText;
	IBOutlet	UILabel	*labelStats;
	IBOutlet	UIImageView *imageFlag;
	NSNumber *currentCardNumber;
	NSNumber *cardsInSession;
	id <BrowseFrontViewDelegate> delegate;
	
}

@property (nonatomic, retain) Card *card;
@property (nonatomic, retain) UILabel *labelReading;
@property (nonatomic, retain) UILabel *labelTopic;
@property (nonatomic, retain) UILabel *labelNumber;
@property (nonatomic, retain) UILabel *labelCardText;
@property (nonatomic, retain) UILabel *labelStats;
@property (nonatomic, retain) UIImageView *imageFlag;
@property (nonatomic, retain) NSNumber *cardsInSession;
@property (nonatomic, retain) NSNumber *currentCardNumber;
@property (assign) id <BrowseFrontViewDelegate> delegate;

- (void)setUILabelTextWithVerticalAlignTop:(NSString *)theText;
- (IBAction)seeAnswer:(id)sender;
- (void)previousCardButtonPressed:(id)sender;
- (void)endSessionClicked:(id)sender;
- (void)favoriteButtonPressed:(id)sender;

@end

@protocol BrowseFrontViewDelegate <NSObject>
@optional
- (void) turnToBack;
- (void) previousCard;
- (void) endSession;

@end
