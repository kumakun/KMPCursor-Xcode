//
//  KMPCursor.h
//  KMPCursor
//
//  Created by Bruce on 15/11/24.
//  Copyright © 2015年 KumaPower. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "KMPPreferenceWindowController.h"

@class KMPCursor;

static KMPCursor *sharedPlugin;

@interface KMPCursor : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@property (nonatomic, assign) KMPCursorType cursorType;

@end