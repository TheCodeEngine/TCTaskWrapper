//
//  TCTaskWrapper.m
//  TCTaskWrapper
//
//  Created by Konstantin Stoldt on 30.05.13.
//  Copyright (c) 2013 TheCodeEngine. All rights reserved.
//

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
            *error = [self errorWithCode:101 userInfoString:@"Task Fail"];
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
- (NSString*)outPutDataToString
{
    return [[NSString alloc] initWithData:self.outPutData encoding:NSASCIIStringEncoding];
}

#pragma mark - Private Helper

- (NSError*)errorWithCode:(int)code userInfoString:(NSString*)userInfoString
{
    NSDictionary *userInfoDict = [NSDictionary dictionaryWithObject:userInfoString forKey:NSLocalizedFailureReasonErrorKey];
    return [NSError errorWithDomain:NSOSStatusErrorDomain code:code userInfo:userInfoDict];
}

@end
