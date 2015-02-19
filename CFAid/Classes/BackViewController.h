//
//  BackViewController.h
//  CFAid
//
//  Created by Morgan Intrator on 8/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

#define LF '\n'

@protocol BackViewDelegate;

@interface BackViewController : UIViewController {
	IBOutlet UIScrollView *scrollView;
	IBOutlet UILabel *labelAnswer;
	IBOutlet UIImageView *imageFlag;
	IBOutlet UILabel *labelCardNumber;
	NSString *correctOrIncorrect;
	UISegmentedControl *answer;
	Card *card;
	id <BackViewDelegate> delegate;

}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UILabel *labelAnswer;
@property (nonatomic, retain) UILabel *labelCardNumber;
@property (nonatomic, retain) UIImageView *imageFlag;
@property (nonatomic, retain) NSString *correctOrIncorrect;
@property (nonatomic, retain) UISegmentedControl *answer;
@property (nonatomic, retain) Card *card;
@property (nonatomic, assign) id <BackViewDelegate> delegate;

- (void)setupView;
- (IBAction)segmentAction:(id)sender;
- (void)rightButtonPressed;
- (void)wrongButtonPressed;
- (void)endSessionClicked:(id)sender;
- (void)backButtonPressed:(id)sender;
- (void)favoriteButtonPressed:(id)sender;

@end

@protocol BackViewDelegate <NSObject>
@optional
- (void) endSession;
- (void) nextCard:(NSString *)string;
- (void) goBackToFront;

@end