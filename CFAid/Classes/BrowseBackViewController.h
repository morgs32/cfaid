//
//  BackViewController.h
//  CFAid
//
//  Created by Morgan Intrator on 8/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@protocol BrowseBackViewDelegate;

@interface BrowseBackViewController : UIViewController {
	IBOutlet UIScrollView *scrollView;
	IBOutlet UIImageView *imageFlag;
	IBOutlet UILabel *labelCardNumber;
	Card *card;
	id <BrowseBackViewDelegate> delegate;
	
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *imageFlag;
@property (nonatomic, retain) UILabel *labelCardNumber;
@property (nonatomic, retain) Card *card;
@property (nonatomic, assign) id <BrowseBackViewDelegate> delegate;

- (void)lastCard;
- (void)setupView;
- (IBAction)segmentAction:(id)sender;
- (void)nextCardButtonPressed;
- (void)endSessionClicked:(id)sender;
- (void)backButtonPressed:(id)sender;
- (void)favoriteButtonPressed:(id)sender;

@end

@protocol BrowseBackViewDelegate <NSObject>
@optional
- (void) nextCard;
- (void) goBackToFront;
- (void) endSession;

@end