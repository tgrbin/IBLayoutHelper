//
//  MainWindow.m
//  IBLayoutHelper
//
//  Created by Tomislav Grbin on 18/11/13.
//  Copyright (c) 2013 Five Minutes ltd. All rights reserved.
//

#import "MainWindow.h"
#import "GlobalShortcuts.h"

@interface MainWindow()
@property (nonatomic, assign) BOOL floating;
@end

@implementation MainWindow {
  NSPoint dragStartPoint;
  NSPoint windowStartPoint;
}

- (void)awakeFromNib {
  [GlobalShortcuts addObserver:self
                     forAction:kGlobalShortcutFloatOrUnfloat];
}

- (void)mouseDown:(NSEvent *)theEvent {
  windowStartPoint = self.frame.origin;
  dragStartPoint = [NSEvent mouseLocation];
}

- (void)mouseDragged:(NSEvent *)theEvent {
  NSPoint point = [NSEvent mouseLocation];
  self.frameOrigin = NSMakePoint(windowStartPoint.x + point.x - dragStartPoint.x,
                                 windowStartPoint.y + point.y - dragStartPoint.y);
}

- (void)globalShortcutPressed:(NSNumber *)shortcut {
  self.floating = !self.floating;
}

- (void)setFloating:(BOOL)floating {
  _floating = floating;
  self.level = floating? NSScreenSaverWindowLevel: NSNormalWindowLevel;
  self.ignoresMouseEvents = _floating;
}

@end
