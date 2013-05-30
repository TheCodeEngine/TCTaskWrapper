//
//  AppDelegate.m
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

#import "AppDelegate.h"

#import "TCTaskWrapper.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

#pragma mark - Syncron Task

- (IBAction)syncronRunTaskAction:(id)sender
{
    NSString *launchPath = self.syncronLaunchPathTextField.stringValue;
    NSArray *arguments = [self.syncronArguments.stringValue componentsSeparatedByString:@","];
    
    // [self syncroniusTextFieldAppend:[NSString stringWithFormat:@"Task: %@, %@", launchPath, arguments]];
    
    NSError *taskRUnError;
    TCTaskWrapper *task = [[TCTaskWrapper alloc] initWithTaskPath:[NSURL URLWithString:launchPath] arguments:arguments];
    if ( ![task runTaskSyncronError:&taskRUnError] ) {
        NSAlert *alert = [NSAlert alertWithError:taskRUnError];
        [self syncroniusTextFieldAppend:@"ERROR:"];
        [self syncroniusTextFieldAppend:taskRUnError.localizedDescription];
        [self syncroniusTextFieldAppend:@"\n"];
        [self syncroniusTextFieldAppend:[task outPutDataToString]];
        //[alert runModal];
    }
    else
    {
        [self syncroniusTextFieldAppend:[task outPutDataToString]];
    }
    
    [self syncroniusTextFieldAppend:@"- - - - - - - - - - - - - - - - - - - - - - - - - -\n"];
}

- (void)syncroniusTextFieldAppend:(NSString*)string
{
    [[_syncronConsole textStorage] appendAttributedString:[[NSAttributedString alloc] initWithString:string]];
    [_syncronConsole scrollRangeToVisible:NSMakeRange([[_syncronConsole string] length], 0)];
}

@end
