//
//  AppDelegate.m
//  plistToJson
//
//  Created by Ethan on 14/5/15.
//  Copyright (c) 2015 EthanolStudio. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSTextField *statusField;
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (IBAction)covertPlistToJson:(id)sender {
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    [panel setCanChooseDirectories:NO];
    [panel setCanChooseFiles: YES];
    [panel setAllowsMultipleSelection:NO];
    [panel setMessage:@"Choose a plist file"];
    [panel beginWithCompletionHandler:^(NSInteger result) {
        NSLog(@"%@",[panel URL]);
        NSDictionary *serialization = [[NSDictionary alloc]initWithContentsOfURL:[panel URL]];
        if(serialization){
            NSError *error;
            NSLog(@"%@",serialization);
            //             NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@converted.json",[panel directoryURL]]];
            NSData *data = [NSJSONSerialization dataWithJSONObject:serialization options:NSJSONWritingPrettyPrinted error:&error];
            NSString *jsonString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];

           
            NSSavePanel* savePanel = [NSSavePanel savePanel];
            [savePanel setNameFieldStringValue:@"converted.json"];
            [savePanel setDirectoryURL:[panel directoryURL]];
            [savePanel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
                 NSError *error;
                 if(result == NSFileHandlingPanelOKButton){
                     if([jsonString writeToURL:[savePanel URL] atomically:YES encoding:NSUTF8StringEncoding error:&error]){
                         [self.statusField setStringValue:@"Success😆!"];
                         [self.statusField setTextColor:[NSColor greenColor]];
                     }else{
                         [self.statusField setStringValue:@"Failed😨!"];
                         [self.statusField setTextColor:[NSColor greenColor]];
                     }
                }
            }];
        }
        
        NSArray *serializationa = [[NSArray alloc]initWithContentsOfURL:[panel URL]];
        if(serializationa){
            NSError *error;
            NSLog(@"a: %@",serializationa);
            NSData *data = [NSJSONSerialization dataWithJSONObject:serializationa options:NSJSONWritingPrettyPrinted error:&error];
            NSString *jsonString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSSavePanel* savePanel = [NSSavePanel savePanel];
            [savePanel setNameFieldStringValue:@"converted.json"];
            [savePanel setDirectoryURL:[panel directoryURL]];
            [savePanel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
                NSError *error;
                if(result == NSFileHandlingPanelOKButton){
                    if([jsonString writeToURL:[savePanel URL] atomically:YES encoding:NSUTF8StringEncoding error:&error]){
                        [self.statusField setStringValue:@"Success 😆!"];
                        [self.statusField setTextColor:[NSColor greenColor]];
                    }else{
                        [self.statusField setStringValue:@"Failed 😨!"];
                        [self.statusField setTextColor:[NSColor greenColor]];
                    }
                    
                }
            }];
        }
        
        
        
        
        
    }];
}

@end
