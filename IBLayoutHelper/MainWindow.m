//
//  MainWindow.m
//  IBLayoutHelper
//
//  Created by Tomislav Grbin on 18/11/13.
//  Copyright (c) 2013 Five Minutes ltd. All rights reserved.
//

#import "MainWindow.h"

@implementation MainWindow {
  NSPoint dragStartPoint;
  NSPoint windowStartPoint;
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

@end
