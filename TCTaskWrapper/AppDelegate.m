//
//  AppDelegate.m
//  TCTaskWrapper
//
//  Created by Konstantin Stoldt on 30.05.13.
//  Copyright (c) 2013 TheCodeEngine. All rights reserved.
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
