//
//  GlobalShortcuts.m
//  Martin
//
//  Created by Tomislav Grbin on 1/29/13.
//
//

#import "GlobalShortcuts.h"
#import <Carbon/Carbon.h>
#import "DefaultsManager.h"

@implementation GlobalShortcuts

static OSType signatures[] = { 'floa' };

+ (void)initialize {
  EventTypeSpec eventType;
  eventType.eventClass = kEventClassKeyboard;
  eventType.eventKind = kEventHotKeyPressed;
  InstallApplicationEventHandler(&hotkeyHandler, 1, &eventType, NULL, NULL);

  hotKeyRefsDictionary = [NSMutableDictionary new];
}

+ (void)setupShortcuts {
  for (int i = 0; i < kNumberOfGlobalShortcuts; ++i) {
    EventHotKeyID hkID;
    hkID.signature = signatures[i];
    hkID.id = i+1;

    KeyCombo keyCombo = [self shortcutForAction:i];

    if (keyCombo.code != -1) {
      EventHotKeyRef hkRef = refForAction(i);
      if (hkRef) UnregisterEventHotKey(hkRef);

      RegisterEventHotKey((int)keyCombo.code, (int)SRCocoaToCarbonFlags(keyCombo.flags), hkID, GetApplicationEventTarget(), 0, &hkRef);
      setRefForAction(i, hkRef);
    }
  }
}

+ (void)addObserver:(id)observer forAction:(GlobalShortcutAction)action {
  [[NSNotificationCenter defaultCenter] addObserver:observer
                                           selector:@selector(globalShortcutPressed:)
                                               name:stringForAction(action)
                                             object:@(action)];
}

#pragma mark - get and set shortcuts

+ (KeyCombo)defaultShortcutForAction:(GlobalShortcutAction)action {
  switch (action) {
    case kGlobalShortcutFloatOrUnfloat:
      return SRMakeKeyCombo(30, NSCommandKeyMask | NSShiftKeyMask); // shift + cmd + }
  }
}

+ (KeyCombo)shortcutForAction:(GlobalShortcutAction)action {
  NSDictionary *shortcuts = [DefaultsManager objectForKey:kDefaultsKeyGlobalShortcuts];
  NSString *shortcutString = [shortcuts objectForKey:stringForAction(action)];
  if (shortcutString == nil) return [self defaultShortcutForAction:action];

  NSArray *twoNumbers = [shortcutString componentsSeparatedByString:@" "];
  return SRMakeKeyCombo([twoNumbers[0] intValue], [twoNumbers[1] intValue]);
}

+ (void)setShortcut:(KeyCombo)shortcut forAction:(GlobalShortcutAction)action {
  NSString *shortcutString = [NSString stringWithFormat:@"%ld %ld", (long)shortcut.code, (unsigned long)shortcut.flags];

  NSMutableDictionary *dict = [[DefaultsManager objectForKey:kDefaultsKeyGlobalShortcuts] mutableCopy];
  dict[stringForAction(action)] = shortcutString;
  [DefaultsManager setObject:dict forKey:kDefaultsKeyGlobalShortcuts];

  [self setupShortcuts];
}

+ (void)resetToDefaults {
  for (int i = 0; i < kNumberOfGlobalShortcuts; ++i) {
    [self setShortcut:[self defaultShortcutForAction:i] forAction:i];
  }
}

#pragma mark - event handler

static OSStatus hotkeyHandler(EventHandlerCallRef nextHandler, EventRef theEvent, void *userData) {
  EventHotKeyID hkCom;
  GetEventParameter(theEvent, kEventParamDirectObject, typeEventHotKeyID, NULL, sizeof(hkCom), NULL, &hkCom);

  GlobalShortcutAction action = hkCom.id - 1;
  [[NSNotificationCenter defaultCenter] postNotificationName:stringForAction(action)
                                                      object:@(action)];

  return noErr;
}

#pragma mark - util

static NSString *stringForAction(GlobalShortcutAction action) {
  return [NSString stringWithFormat:@"GlobalShortcut_%d", action];
}

static NSMutableDictionary *hotKeyRefsDictionary;

static EventHotKeyRef refForAction(GlobalShortcutAction action) {
  NSValue *val = hotKeyRefsDictionary[@(action)];
  if (val == nil) return NULL;
  return [val pointerValue];
}

static void setRefForAction(GlobalShortcutAction action, EventHotKeyRef hkRef) {
  NSValue *val = [NSValue valueWithPointer:hkRef];
  hotKeyRefsDictionary[@(action)] = val;
}

@end
