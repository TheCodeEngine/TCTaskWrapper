//
//  TCTaskWrapper.m
//  TCTaskWrapper
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
/**
 @file TCTaskWrapper.m
 @brief Abstraction eines NSTask
 **/

#import "TCTaskWrapper.h"

@implementation TCTaskWrapper

#pragma mark - init
- (id)initWithTaskPath:(NSURL*)path arguments:(NSArray*)arguments
{
    if ( self = [super init] )
    {
        self.launchpath = path;
        self.arguments = arguments;
    }
    return self;
}

#pragma mar - Task
/**
 @brief Run task Syncronly
 @retrun BOOL
    __YES__ task run success, __NO__ Task has Error look in the NSError
 
 @Error
    101: Task failed
        Task exit status != 0
    199: Task Exception General
        In the Error you can find the Exception Message
    102: Task Exception launch path not accessible
**/
- (BOOL)runTaskSyncronError:(NSError**)error
{
    @try
    {
        // Validaieren
        NSAssert(self.launchpath, @"LaunPath must set");
        NSAssert(self.arguments, @"Argumentsmust set");
        
        // Create Task
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath:[self.launchpath absoluteString]];
        [task setArguments:self.arguments];
        
        // Create pipe to read data from the task
        NSPipe *pipeStandartOut = [[NSPipe alloc] init];
        [task setStandardOutput:pipeStandartOut];
        
        // Launch Process
        [task launch];
        
        // Read Data from Pipe
        self.outPutData = [[pipeStandartOut fileHandleForReading] readDataToEndOfFile];
        
        // Check Task Status
        [task waitUntilExit];
        int statusTask = [task terminationStatus];
        if ( statusTask != 0 )
        {
            *error = [self errorWithCode:101 userInfoString:@"Task exit status not 0"];
            return NO;
        }
        
        return YES;
    }
    @catch (NSException *exception)
    {
        if ( [exception.reason isEqualToString:@"launch path not accessible"] )
        {
            *error = [self errorWithCode:102 userInfoString:@"Task launch path not accessible"];
        }
        else
        {
            *error = [self errorWithCode:199 userInfoString:[NSString stringWithFormat:@"Task fail with Exception: %@", exception.description]];
        }
        return NO;
    }
}

#pragma mark - Helper
/**
 @brief Return the NSData ouput Data from NSTask as NSString
 @return string, data from NSTask with ASCIIString Encoding
**/
- (NSString*)outPutDataToString
{
    return [[NSString alloc] initWithData:self.outPutData encoding:NSASCIIStringEncoding];
}

#pragma mark - Private Helper
/**
 @brief Privtae Method to esay create a NSError
 @return error, NSError
**/
- (NSError*)errorWithCode:(int)code userInfoString:(NSString*)userInfoString
{
    NSDictionary *userInfoDict = [NSDictionary dictionaryWithObject:userInfoString forKey:NSLocalizedFailureReasonErrorKey];
    return [NSError errorWithDomain:NSOSStatusErrorDomain code:code userInfo:userInfoDict];
}

@end
