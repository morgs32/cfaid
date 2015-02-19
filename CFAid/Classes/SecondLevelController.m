//
//  SecondLevelController.m
//  CFAid
//
//  Created by Morgan Intrator on 9/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SecondLevelController.h"


@implementation SecondLevelController
@synthesize managedObjectContext;
@synthesize buttonImage;
@synthesize buttonLabel;
@synthesize list;

- (void)dealloc {
	[managedObjectContext release];
	[buttonImage release];
	[buttonLabel release];
	[list release];
    [super dealloc];
}

@end
