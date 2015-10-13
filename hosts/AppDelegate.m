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
    [task1 setArguments: [NSArray arrayWithObjects: @"-c",command, nil]];
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
                              arguments:@[@"-c", cmd]]
     waitUntilExit];
}

// Bottom button action
- (IBAction)runBashCommand:(id)sender {
    
    // SOURCE PATH - construct a path for the source file's location
    
    // (1) return the user's home directory
    NSString *myHomeDirectory = NSHomeDirectory();
    // (2) build a path branching off Home (repace with your path)
    NSString *pathFromHomeDirectory = @"/Documents/Life/code/hosts/notes.rtf";
    // (3) combine the results of steps 1 and 2
    NSString *sourcePath = [myHomeDirectory stringByAppendingPathComponent:pathFromHomeDirectory];
    
    // DESTINATION PATH - construct a destination path for the copy
    
    // (1) return the user's Desktop directory
    NSArray* desktopPaths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
    NSString *myDesktopPath = [desktopPaths objectAtIndex:0];
    // (2) build a path and filename branching off Desktop
    NSString *newFileName = @"notes.rtf";
    // (3) combine the results of steps 1 and 2
    NSString *saveFilePath = [myDesktopPath stringByAppendingPathComponent:newFileName];

    // COPY from source path to destination path
    [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:saveFilePath error:nil];
    
    // HANDLE ERRORS - right now nil

    // copy file using shell instead
    [[NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:@[@"-c", @"~Desktop/notes.rtf ~/Desktop/notes.bak"]] waitUntilExit];

    [[NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:@[@"-c", @"sudo -s echo '192.0.0.1 www.facebook.com' >> /etc/hosts"]] waitUntilExit];
     
//    BOOL fileExists = [fileManager fileExistsAtPath:filePath];
//    NSLog(@"%@", fileExists ? @"y":@"n");

    // method 1 for executing command
    [self runSystemCommand:@"ls -a"];
    
    // method 2 for executing command
    [self runShellCommand:@"pwd"];
    
    // create new external task
    NSTask *task = [[NSTask alloc] init];
    
    // launch terminal
    task.launchPath = @"/usr/bin/say";
    
    // define command with args
    NSString* speakingPhrase = self.textField.stringValue;
    task.arguments  = @[@"-v",@"victoria",speakingPhrase];
    
    // execute command
    [task launch];
    [task waitUntilExit];
}

- (IBAction)textField:(id)sender {
}

@end
