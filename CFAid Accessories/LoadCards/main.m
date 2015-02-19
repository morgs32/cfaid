//
//  main.m
//  LoadCards
//
//  Created by Morgan Intrator on 8/25/09.
//  Copyright Pohleusis 2009. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "Card.h"

NSString *applicationLogDirectory();
NSManagedObjectContext *managedObjectContext();

int main(int argc, char *argv[])

{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	//setup mom
    NSArray *bundles = [NSArray arrayWithObject:[NSBundle bundleForClass:[Card self]]];
    NSManagedObjectModel *mom = [NSManagedObjectModel alloc];
	mom = [[NSManagedObjectModel mergedModelFromBundles:bundles] retain];
    NSLog(@"mom: %@", mom);
	
	//setup support directory
    if (applicationLogDirectory() == nil) {
        NSLog(@"Could not find application support directory\nExiting...");
        exit(1);
    }
	
	//setup moc
    NSManagedObjectContext *moc = managedObjectContext();
	
	//get cvs components into arrary
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *cvsFilePath = [bundle pathForResource: @"LoadCards" ofType: @"csv"];
	NSString *data = [[NSString alloc] initWithContentsOfFile:cvsFilePath];
	
	NSMutableArray *linesArray = [[NSMutableArray alloc] init];
	NSScanner *scanner1 = [NSScanner scannerWithString:data];
	NSString *separatorString = [[NSString alloc] initWithString: @",EndOfLine"];
	NSString *line = [[NSString alloc] init];
	while (![scanner1 isAtEnd]) {
		[scanner1 scanUpToString:separatorString intoString:&line];
		[linesArray addObject:line];
		[scanner1 scanString:separatorString intoString:NULL];
	}
	
	[scanner1 release];
	[line release];
	
	NSLog(@"The csv file is:");
	for (id	obj in linesArray)
		NSLog(@"%@", obj);
	
	[linesArray removeObjectAtIndex:0];
	NSError *error = nil;
	separatorString = @",";
	
	for (id obj in linesArray) 
	{
		NSScanner *theScanner = [NSScanner scannerWithString:obj];
		
		NSInteger first;
		NSInteger second;
		NSString *third = [[NSString alloc] init];
		NSString *fourth = [[NSString alloc] init];
		NSInteger fifth;
		NSString *sixth = [[NSString alloc] init];
		NSString *seventh = [[NSString alloc] init];
		
		[theScanner scanInteger:&first];
		[theScanner scanString:separatorString intoString:NULL];
		[theScanner scanInteger:&second];
		[theScanner scanString:separatorString intoString:NULL];
		[theScanner scanUpToString:separatorString intoString:&third];
		[theScanner scanString:separatorString intoString:NULL];
		[theScanner scanUpToString:separatorString intoString:&fourth];
		[theScanner scanString:separatorString intoString:NULL];
		[theScanner scanInteger:&fifth];
		[theScanner scanString:separatorString intoString:NULL];
		[theScanner scanUpToString:separatorString intoString:&sixth];
		[theScanner scanString:separatorString intoString:NULL];
		seventh = [obj substringFromIndex:[theScanner scanLocation]];
		
		Card *card = (Card *)[NSEntityDescription insertNewObjectForEntityForName:@"Card" 
														   inManagedObjectContext:moc];
		
		[card setFormula: third];
		[card setBack: seventh];
		[card setFront: sixth];		
		[card setNumberID: [NSNumber numberWithInt:first]];
		[card setNumberOrder: [NSNumber numberWithInt:second]];
		[card setTopic: fourth];
		[card setReading: [NSNumber numberWithInt:fifth]];
		
		error = nil;
		if (![managedObjectContext() save: &error]) {
			NSLog(@"Error while saving\n%@",
				  ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
			exit(1);
		}
		
		[theScanner release];
		[third release];
		[fourth release];
		[sixth release];
		[seventh release];
		[card release];
	
	}

	
	
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Card" inManagedObjectContext:moc];
	[request setEntity:entity];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"numberID" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptors release];
	[sortDescriptor release];
	
	error = nil;
	NSMutableArray *mutableFetchResults = [[moc executeFetchRequest:request error:&error] mutableCopy];
	if ((error != nil) || (mutableFetchResults == nil))
	{
		NSLog(@"Error while fetching\n%@", ([error localizedDescription] != nil) ? [error localizedDescription]
			  : @"Unknown Error");
		exit(1);
	}
	
	NSArray *dataArray = [[NSArray alloc] initWithArray:mutableFetchResults];
	[mutableFetchResults release];
	[request release];
	
	NSLog(@"The cards are as follows:");
	
	for (id obj in dataArray)
	{
		NSLog(@"%@", obj);
	}
	
	[separatorString release];
	[linesArray release];
	[bundle release];
	[cvsFilePath release];
	[data release];
	[error release];
	[pool drain];
	return 0;
}


NSString *applicationLogDirectory() {
    NSString *LOG_DIRECTORY = @"LoadCards";
    static NSString *ald = nil;
	
    if (ald == nil) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains
		(NSLibraryDirectory, NSUserDomainMask, YES);
		
        if ([paths count] == 1) {
            ald = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Logs"];
            ald = [ald stringByAppendingPathComponent:LOG_DIRECTORY];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            BOOL isDirectory = NO;
			
            if (![fileManager fileExistsAtPath:ald isDirectory:&isDirectory]) {
                if (![fileManager createDirectoryAtPath:ald attributes:nil]) {
                    ald = nil;
                }
            }
            else {
                if (!isDirectory) {
                    ald = nil;
                }
            }
        }
    }
    return ald;
}


NSManagedObjectContext *managedObjectContext() {
	
    static NSManagedObjectContext *moc = nil;
	
    if (moc != nil) {
        return moc;
    }
	
    moc = [[NSManagedObjectContext alloc] init];
	NSManagedObjectModel *mom = [NSManagedObjectModel alloc];
	NSArray *bundles = [NSArray arrayWithObject:[NSBundle bundleForClass:[Card self]]];
	mom = [[NSManagedObjectModel mergedModelFromBundles:bundles] retain];
	
    NSPersistentStoreCoordinator *coordinator =
	[[NSPersistentStoreCoordinator alloc]
	 initWithManagedObjectModel:mom];
    [moc setPersistentStoreCoordinator: coordinator];
	
    NSString *STORE_TYPE = NSSQLiteStoreType;
    NSString *STORE_FILENAME = @"CoreDataCards.sqlite";
	
    NSError *error;
    NSURL *url = [NSURL fileURLWithPath:
				  [applicationLogDirectory() stringByAppendingPathComponent:STORE_FILENAME]];
	
    NSPersistentStore *newStore = [coordinator addPersistentStoreWithType:STORE_TYPE
															configuration:nil
																	  URL:url
																  options:nil
																	error:&error];
	NSLog(@"THE URL IS %@", url);
	
    if (newStore == nil) {
        NSLog(@"Store Configuration Failure\n%@",
			  ([error localizedDescription] != nil) ?
			  [error localizedDescription] : @"Unknown Error");
    }
    return moc;
}