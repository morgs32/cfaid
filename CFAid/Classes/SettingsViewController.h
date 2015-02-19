//
//  SettingsViewController.h
//  CFAid
//
//  Created by Morgan Intrator on 9/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondLevelController.h"

#define kSwitchTag 100


@interface SettingsViewController : SecondLevelController <UITableViewDelegate, UITableViewDataSource> {
	UITableViewCell *settingsButtonCell;
}

@property (nonatomic, assign) IBOutlet UITableViewCell *settingsButtonCell;

- (IBAction)switchChanged:(UISwitch *)topicSwitch;

@end
