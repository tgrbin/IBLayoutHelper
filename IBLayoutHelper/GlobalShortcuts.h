//
//  GlobalShortcuts.h
//  Martin
//
//  Created by Tomislav Grbin on 1/29/13.
//
//

#import <Foundation/Foundation.h>
#import "SRCommon.h"

#define kNumberOfGlobalShortcuts 1

typedef enum {
  kGlobalShortcutFloatOrUnfloat
} GlobalShortcutAction;

@interface GlobalShortcuts : NSObject

+ (void)setupShortcuts;

+ (KeyCombo)shortcutForAction:(GlobalShortcutAction)action;
+ (void)setShortcut:(KeyCombo)shortcut forAction:(GlobalShortcutAction)action;

+ (void)resetToDefaults;

// globalShortcutPressed:(nsnumber *)action will be called on observer!
+ (void)addObserver:(id)observer forAction:(GlobalShortcutAction)action;

@end
