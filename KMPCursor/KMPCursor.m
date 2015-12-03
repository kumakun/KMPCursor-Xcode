//
//  KMPCursor.m
//  KMPCursor
//
//  Created by Bruce on 15/11/24.
//  Copyright © 2015年 KumaPower. All rights reserved.
//

#import "KMPCursor.h"
#import "JRSwizzle.h"
#import "NSCursor+Custom.h"

NSString * const kUserDefaultsKeyCursorType = @"KMPCursorType";

@interface KMPCursor()<KMPPreferenceWindowDelegate>

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@property (nonatomic, strong) KMPPreferenceWindowController *preferenceWindow;

@end

@implementation KMPCursor

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[KMPCursor alloc] initWithBundle:plugin];
        });
    }
}

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        
        NSError *error;
        [[NSCursor class]jr_swizzleMethod:@selector(set) withMethod:@selector(kmp_set) error:&error];
        if (error) {
            NSLog(@"swizzle error %@", error);
        }
        
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
        
        //Test
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(notificationListener:)
//                                                     name:nil object:nil];
    }
    return self;
}

//-(void)notificationListener:(NSNotification *)noti {
//    NSLog(@" Notification: %@  object:%@", [noti name], [noti object]);
//}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    //removeObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    KMPCursorType type = [userDefaults integerForKey:kUserDefaultsKeyCursorType];
    self.cursorType = type;
    
    [self createMenuItem];
}

- (void)createMenuItem
{
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (menuItem) {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Switch Cursor" action:@selector(switchCursor:) keyEquivalent:@""];
        [actionMenuItem setTarget:self];
        [[menuItem submenu] addItem:actionMenuItem];
    }
}

- (KMPPreferenceWindowController *)preferenceWindow
{
    if (!_preferenceWindow) {
        _preferenceWindow = [[KMPPreferenceWindowController alloc] initWithWindowNibName:@"KMPPreferenceWindowController"];
        _preferenceWindow.delegate = self;
    }
    return _preferenceWindow;
}

- (void)switchCursor:(NSMenuItem *)sender
{
    [self.preferenceWindow setCursorType:self.cursorType];
    [self.preferenceWindow.window makeKeyAndOrderFront:self];
    [self.preferenceWindow.window center];
    sender.state = NSOffState;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - KMPPreferenceWindowDelegate

- (void)preferenceWindowDidSelectCursor:(KMPCursorType)type
{
    self.cursorType = type;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:type forKey:kUserDefaultsKeyCursorType];
    [userDefaults synchronize];
}

@end







