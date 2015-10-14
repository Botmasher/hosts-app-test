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

    // path to the installHosts shell script within project
    NSString *shellScriptPath = [[NSBundle mainBundle] pathForResource:@"installHosts" ofType:@"sh"];
    // prepend bash path to run installHosts shell script
    NSString *shellScriptRunCommand = [NSString stringWithFormat: @"\"/bin/bash %@\"", shellScriptPath];
    
    // build AppleScript command for running shell script with permissions
    NSString *appleScriptCommand = [[NSString alloc] initWithFormat:@"do shell script %@ with administrator privileges", shellScriptRunCommand];
    
    // type to AppleScript
    NSAppleScript *shellScript;
    shellScript = [[NSAppleScript alloc] initWithSource:appleScriptCommand];
    
    // run script
    NSDictionary *errorsDictionary = NULL;
    [shellScript executeAndReturnError:&errorsDictionary];
    
    // release init string
    //[appleScriptCommand release];
    
    
    
    // TEST CODE BELOW HERE
    
    /*
     *  Copy files using NSFileManager
     */
    
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
    // PLEASE ADD CODE TO HANDLE ERRORS - right now nil
    [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:saveFilePath error:nil];

    /*
     *  Check if a file already exists using NSFileManager
     */
    
    //BOOL fileExists = [fileManager fileExistsAtPath:filePath];
    //NSLog(@"%@", fileExists ? @"y":@"n");
    
    
    /*
     *  Copy file using shell instead
     */
    
    //[[NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:@[@"-c", @"cp ~Desktop/notes.rtf ~/Desktop/notes.bak"]] waitUntilExit];

    
    /*
     *  NSTask shell commands tests
     */
    
    // create a file and print lines to it

//    [[NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:@[@"-c", @"touch ~/Desktop/new.txt"]] waitUntilExit];
//    
//    [[NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:@[@"-c", @"echo '192.0.0.1 www.exampleurl.com' >> ~/Desktop/new.txt"]] waitUntilExit];
//
//    [[NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:@[@"-c", @"echo '192.0.0.1 www.exampleurl2.com' >> ~/Desktop/new.txt"]] waitUntilExit];
    
    // run defined method 1 for executing command
    [self runSystemCommand:@"ls -a"];
    
    // run defined method 2 for executing command
    [self runShellCommand:@"pwd"];

    
    /*
     *  NSTask run a specific command line utility
     */
    
    // define command with args
    //task.arguments = @[@"-c",@""];
    
//    // TEST #1 running shell script
//    // returns "Permission denied"
//    int pid = [[NSProcessInfo processInfo] processIdentifier];
//    NSPipe *pipe = [NSPipe pipe];
//    NSFileHandle *file = pipe.fileHandleForReading;
//    
//    NSTask *task = [[NSTask alloc] init];
//    task.launchPath = @"/bin/sh";
//    task.arguments = @[@"-c", @"~/Desktop/test-script.sh"];
//    task.standardOutput = pipe;
//    
//    [task launch];
//    
//    NSData *data = [file readDataToEndOfFile];
//    [file closeFile];
//    
//    NSString *shOutput = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
//    NSLog (@"sh returned:\n%@", shOutput);
    
//    // TEST #2 running shell script
//    // returns "No such file or directory"
//    NSTask *task = [[NSTask alloc] init];
//    [task setLaunchPath:@"/bin/sh"];
//    [task setArguments:[NSArray arrayWithObjects:@"~/Desktop/test-script.sh", nil]];
//    [task setStandardOutput:[NSPipe pipe]];
//    [task setStandardInput:[NSPipe pipe]];
//    
//    [task launch];
//    [task waitUntilExit];

//    // TEST running "say" task
//
//    // create new external task
//    NSTask *task = [[NSTask alloc] init];
//    
//    // launch terminal
//    task.launchPath = @"/usr/bin/say";
//    
//    // define command with args
//    NSString* speakingPhrase = self.textField.stringValue;
//    task.arguments = @[@"-v",@"victoria",speakingPhrase];
//    
//    // execute command
//    [task launch];
//    [task waitUntilExit];
}

- (IBAction)textField:(id)sender {
}

@end
