//
//  KMPPreferenceWindowController.m
//  KMPCursor
//
//  Created by Bruce on 15/11/30.
//  Copyright © 2015年 KumaPower. All rights reserved.
//

#import "KMPPreferenceWindowController.h"

@interface KMPPreferenceWindowController ()
@property (weak) IBOutlet NSButton *option0Button;
@property (weak) IBOutlet NSButton *option1Button;
@property (weak) IBOutlet NSButton *option2Button;
@end

@implementation KMPPreferenceWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    self.window.title = @"Switch Cursor";
}

- (void)windowWillClose:(NSNotification *)notification
{
    
}

- (void)setCursorType:(KMPCursorType)type
{
    [self.option0Button setState:NSOffState];
    [self.option1Button setState:NSOffState];
    [self.option2Button setState:NSOffState];
    switch (type) {
        case KMPCursorType_origin:
            [self.option0Button setState:NSOnState];
            break;
        case KMPCursorType_white:
            [self.option1Button setState:NSOnState];
            break;
        case KMPCursorType_texture:
            [self.option2Button setState:NSOnState];
            break;
        default:
            break;
    }
}

- (IBAction)option0Click:(NSButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(preferenceWindowDidSelectCursor:)]) {
        [self setCursorType:KMPCursorType_origin];
        [self.delegate preferenceWindowDidSelectCursor:KMPCursorType_origin];
    }
}

- (IBAction)option1Click:(NSButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(preferenceWindowDidSelectCursor:)]) {
        [self setCursorType:KMPCursorType_white];
        [self.delegate preferenceWindowDidSelectCursor:KMPCursorType_white];
    }
}

- (IBAction)option2Click:(NSButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(preferenceWindowDidSelectCursor:)]) {
        [self setCursorType:KMPCursorType_texture];
        [self.delegate preferenceWindowDidSelectCursor:KMPCursorType_texture];
    }
}

@end







