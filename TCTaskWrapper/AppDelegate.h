//
//  AppDelegate.h
//  TCTaskWrapper
//
//  Created by Konstantin Stoldt on 30.05.13.
//  Copyright (c) 2013 TheCodeEngine. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

#pragma mark - Syncron Task
@property (unsafe_unretained) IBOutlet NSTextView *syncronConsole;
@property (weak) IBOutlet NSTextField *syncronLaunchPathTextField;
@property (weak) IBOutlet NSTokenField *syncronArguments;
- (IBAction)syncronRunTaskAction:(id)sender;


@end
