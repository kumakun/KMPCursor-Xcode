//
//  NSCursor+Custom.m
//  KMPCursor
//
//  Created by Bruce on 15/11/30.
//  Copyright © 2015年 KumaPower. All rights reserved.
//

#import "NSCursor+Custom.h"
#import <objc/runtime.h>
#import "KMPCursor.h"

@implementation NSCursor (Custom)

- (NSCursor *)kmp_getCursor1
{
    NSCursor *cursor1;
    cursor1 = (NSCursor *)objc_getAssociatedObject(self, @selector(kmp_getCursor1));
    if (!cursor1) {
        NSPoint hotSpot = self.hotSpot;
        NSBundle *bundle = [NSBundle bundleWithIdentifier:@"uh.kumapower.KMPCursor"];
        cursor1 = [[NSCursor alloc] initWithImage:[bundle imageForResource:@"cursor1"] hotSpot:NSMakePoint(hotSpot.x + 2, hotSpot.y)];
        objc_setAssociatedObject(self, @selector(kmp_getCursor1), cursor1, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cursor1;
}


- (NSCursor *)kmp_getCursor2
{
    NSCursor *cursor2;
    cursor2 = (NSCursor *)objc_getAssociatedObject(self, @selector(kmp_getCursor2));
    if (!cursor2) {
        NSPoint hotSpot = self.hotSpot;
        NSBundle *bundle = [NSBundle bundleWithIdentifier:@"uh.kumapower.KMPCursor"];
        cursor2 = [[NSCursor alloc] initWithImage:[bundle imageForResource:@"cursor2"] hotSpot:NSMakePoint(hotSpot.x + 2, hotSpot.y)];
        objc_setAssociatedObject(self, @selector(kmp_getCursor2), cursor2, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cursor2;
}

- (void)kmp_set
{
    if ([self isEqualTo:[NSCursor IBeamCursor]]) {
        
        KMPCursor *kmpCursor = [KMPCursor sharedPlugin];
        if (kmpCursor) {
            switch (kmpCursor.cursorType) {
                case KMPCursorType_origin:
                    [self kmp_set];
                    break;
                case KMPCursorType_1:
                    [[self kmp_getCursor1] set];
                    break;
                case KMPCursorType_2:
                    [[self kmp_getCursor2] set];
                    break;
                default:
                    break;
            }
        }
    }else{
        [self kmp_set];
    }
}
@end
