//
//  TCTaskWrapper.h
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
 @file TCTaskWrapper.h
 @brief Abstraction eines NSTask
**/

#import <Foundation/Foundation.h>

/**
 @brief Abstraction of a NSTask
**/
@interface TCTaskWrapper : NSObject

/** @brief Path **/
@property NSURL *launchpath;
/** @brief Arguments for Task **/
@property NSArray *arguments;
/** @brief Output Data from Task **/
@property NSData *outPutData;

#pragma mark - init
- (id)initWithTaskPath:(NSURL*)path arguments:(NSArray*)arguments;

#pragma mar - Task
- (BOOL)runTaskSyncronError:(NSError**)error;

#pragma mark - Helper
- (NSString*)outPutDataToString;

@end
