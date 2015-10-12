//
//  AppDelegate.h
//  hosts
//
//  Created by Botmasher (Joshua R) on 10/12/15.
//  Copyright (c) 2015 Botmasher (Joshua R). All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

// submit button
- (IBAction)runBashCommand:(id)sender;

// text box
- (IBAction)textField:(id)sender;

// main text field to display returned values
@property (weak) IBOutlet NSTextField *textField;

@end

