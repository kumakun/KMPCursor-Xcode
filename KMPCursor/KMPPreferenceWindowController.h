//
//  KMPPreferenceWindowController.h
//  KMPCursor
//
//  Created by Bruce on 15/11/30.
//  Copyright © 2015年 KumaPower. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSUInteger, KMPCursorType) {
    KMPCursorType_origin,
    KMPCursorType_white,
    KMPCursorType_new,
};

@protocol KMPPreferenceWindowDelegate <NSObject>

- (void)preferenceWindowDidSelectCursor:(KMPCursorType)type;

@end

@interface KMPPreferenceWindowController : NSWindowController

@property (weak, nonatomic) id<KMPPreferenceWindowDelegate> delegate;
- (void)setCursorType:(KMPCursorType)type;

@end
