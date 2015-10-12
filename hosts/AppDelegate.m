//
//  AppDelegate.m
//  hosts
//
//  Created by Botmasher (Joshua R) on 10/12/15.
//  Copyright (c) 2015 Botmasher (Joshua R). All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

-(void) runShellCommand:(NSString*)command
{
    NSTask *task1 = [[NSTask alloc] init];
    NSPipe *pipe1 = [NSPipe pipe];
    [task1 waitUntilExit];
    [task1 setLaunchPath: @"/bin/sh"];
    [task1 setArguments: [NSArray arrayWithObjects: @"-c",@"cd ~/Documents/Life |ls -a", nil]];
    [task1 setStandardOutput: pipe1];
    [task1 launch];
    
    NSFileHandle *file = [pipe1 fileHandleForReading];
    NSData * data = [file readDataToEndOfFile];
    
    NSString * string;
    string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    NSLog(@"Result: %@", string);
}

-(void) runSystemCommand:(NSString*)cmd
{
    [[NSTask launchedTaskWithLaunchPath:@"/bin/sh"
                              arguments:@[@"-c", @"cd .. |ls -a |echo 'hello'"]]
     waitUntilExit];
}

// Bottom button action
- (IBAction)runBashCommand:(id)sender {
//    [self runSystemCommand:@"ls -a"];
//    [self runSystemCommand:@"cd ~"];
    [self runShellCommand:@"unused"];
//    // create new external task
//    NSTask *task = [[NSTask alloc] init];
//    
//    // launch terminal
//    task.launchPath = @"/usr/bin/sh";
//    
//    // define command with args
//    NSString* speakingPhrase = self.textField.stringValue;
//    task.arguments  = @[speakingPhrase];
//    
//    // execute command
//    [task launch];
//    [task waitUntilExit];
}

- (IBAction)textField:(id)sender {
}

@end
