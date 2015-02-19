//
//  Card.h
//  CoreDataCards
//
//  Created by Morgan Intrator on 11/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Card: NSManagedObject  {
}

@property (nonatomic, retain) NSString *front;
@property (nonatomic, retain) NSString *favorite;
@property (nonatomic, retain) NSString *topic;
@property (nonatomic, retain) NSNumber *reading;
@property (nonatomic, retain) NSString *numberID;
@property (nonatomic, retain) NSNumber *leitnerBox;
@property (nonatomic, retain) NSString *back;
@property (nonatomic, retain) NSString *formula;
@property (nonatomic, retain) NSNumber *numberOrder;

@end



