//
//  TCTaskWrapperTests.m
//  TCTaskWrapperTests
//
//  Created by Konstantin Stoldt on 30.05.13.
//  Copyright (c) 2013 TheCodeEngine. All rights reserved.
//

#import "TCTaskWrapperTests.h"

#import "TCTaskWrapper.h"

@implementation TCTaskWrapperTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    //STFail(@"Unit tests are not implemented yet in TCTaskWrapperTests");
}

#pragma mark - Syncron Task

/**
 Tests
 
 General
 - General Test
 - Test Exit Status != 0
 Variablen
 - launchpath var not set
 - launchPath File not exits
 - Arguments var not set
**/

- (void)test_syncronTask
{
    NSURL *taskURL = [NSURL URLWithString:@"/bin/ls"];
    NSArray *argumetArray = @[@"-l"];
    
    TCTaskWrapper *task = [[TCTaskWrapper alloc] initWithTaskPath:taskURL arguments:argumetArray];
    NSError *taskRunError;
    STAssertTrue([task runTaskSyncronError:&taskRunError], @"Task wrong");
    NSString* stringOutPutFromTask = [task outPutDataToString];
    STAssertTrue([stringOutPutFromTask length] > 10, @"Output Wrong ?");
}

// - Test Exit Status != 0
- (void)test_syncronTask_ExitStatusNotNull
{
    NSURL *taskURL = [NSURL URLWithString:@"/usr/bin/which"];
    NSArray *argumetArray = @[@"thisnotexit"];
    
    TCTaskWrapper *task = [[TCTaskWrapper alloc] initWithTaskPath:taskURL arguments:argumetArray];
    NSError *taskRunError;
    STAssertFalse([task runTaskSyncronError:&taskRunError], @"Task Wrong");
    STAssertTrue(taskRunError.code == 101, @"Wrong Error");
}

// - launchpath var not set
- (void)test_syncronTask_launPathVarNotSet
{
    NSURL *taskURL;
    NSArray *argumetArray = @[@"-l"];
    
    TCTaskWrapper *task = [[TCTaskWrapper alloc] initWithTaskPath:taskURL arguments:argumetArray];
    NSError *taskRunError;
    STAssertFalse([task runTaskSyncronError:&taskRunError], @"Task wrong");
    STAssertTrue(taskRunError.code == 199, @"Wrong Error");
}

// - Wrong launchPaths File not exits
- (void)test_syncronTask_launPathNotExits
{
    NSURL *taskURL = [NSURL URLWithString:@"/bin/cannotexits__"];
    NSArray *argumetArray = @[@"-l"];
    
    TCTaskWrapper *task = [[TCTaskWrapper alloc] initWithTaskPath:taskURL arguments:argumetArray];
    NSError *taskRunError;
    STAssertFalse([task runTaskSyncronError:&taskRunError], @"Task wrong");
    STAssertTrue(taskRunError.code == 102, @"Wrong Error");
}

// - Arguments var not set
- (void)test_syncronTask_ArgumentsVarNotSet
{
    NSURL *taskURL = [NSURL URLWithString:@"/bin/ls"];
    NSArray *argumetArray;
    
    TCTaskWrapper *task = [[TCTaskWrapper alloc] initWithTaskPath:taskURL arguments:argumetArray];
    NSError *taskRunError;
    STAssertFalse([task runTaskSyncronError:&taskRunError], @"Task wrong");
    STAssertTrue(taskRunError.code == 199, @"Wrong Error");
}


@end
