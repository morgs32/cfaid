//
//  Card.h
//  Test1
//
//  Created by Morgan Intrator on 8/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Card :  NSManagedObject  
{
}

@property (retain) NSString *front;
@property (retain) NSString *favorite;
@property (retain) NSString *topic;
@property (retain) NSNumber *formula;
@property (retain) NSNumber *leitnerBox;
@property (retain) NSNumber *reading;
@property (retain) NSNumber *numberID;
@property (retain) NSString *back;
@property (retain) NSNumber *numberOrder;

@end


