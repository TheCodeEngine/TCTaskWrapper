//
//  TCTaskWrapperTests.m
//  TCTaskWrapperTests
//
//  Created by Konstantin Stoldt on 30.05.13.
//
//  Is licensed under the MIT license
//	Copyright (c) 2013, TheCodeEngine, Konstantin Stoldt
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy of
//	this software and associated documentation files (the "Software"), to deal in
//	the Software without restriction, including without limitation the rights to
//	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//	the Software, and to permit persons to whom the Software is furnished to do so,
//	subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//	FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//	COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//	IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "TCTaskWrapperTests.h"

#import "TCTaskWrapper.h"

@implementation TCTaskWrapperTests

/*
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
*/

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
