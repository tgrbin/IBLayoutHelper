//
//  PreferencesWindowController.m
//  IBLayoutHelper
//
//  Created by Tomislav Grbin on 18/11/13.
//  Copyright (c) 2013 Five Minutes ltd. All rights reserved.
//

#import "PreferencesWindowController.h"
#import "SRRecorderControl.h"
#import "GlobalShortcuts.h"
#import "DefaultsManager.h"
#import "AppDelegate.h"

@interface PreferencesWindowController ()
@property (strong) IBOutlet SRRecorderControl *recorderControl;

@property (nonatomic, assign) double mainWindowAlpha;
@end

@implementation PreferencesWindowController

- (id)init {
  return (self = [super initWithWindowNibName:@"PreferencesWindowController"]);
}

- (void)awakeFromNib {
  [_recorderControl setKeyCombo:[GlobalShortcuts shortcutForAction:kGlobalShortcutFloatOrUnfloat]];
  self.mainWindowAlpha = [[DefaultsManager objectForKey:kDefaultsKeyMainWindowAlpha] doubleValue];
}

- (void)shortcutRecorder:(SRRecorderControl *)aRecorder keyComboDidChange:(KeyCombo)newKeyCombo {
  [GlobalShortcuts setShortcut:newKeyCombo
                     forAction:kGlobalShortcutFloatOrUnfloat];
}

- (void)setMainWindowAlpha:(double)mainWindowAlpha {
  _mainWindowAlpha = mainWindowAlpha;
  
  [DefaultsManager setObject:@(_mainWindowAlpha)
                      forKey:kDefaultsKeyMainWindowAlpha];
  ((AppDelegate *)[[NSApplication sharedApplication] delegate]).window.alphaValue = _mainWindowAlpha;
}

@end
