//
//  AppDelegate.m
//  IBLayoutHelper
//
//  Created by Tomislav Grbin on 18/11/13.
//  Copyright (c) 2013 Five Minutes ltd. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate()
@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSImageView *mainImageView;
@property (nonatomic, strong) NSImage *mainImage;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
}

- (IBAction)openPressed:(id)sender {
  NSOpenPanel *panel = [NSOpenPanel openPanel];
  panel.canChooseDirectories = NO;
  panel.canChooseFiles = YES;
  panel.allowsMultipleSelection = NO;
  panel.allowedFileTypes = [NSImage imageFileTypes];
  panel.title = @"Open";
  
  if ([panel runModal] == NSFileHandlingPanelOKButton) {
    NSURL *url = panel.URLs[0];
    self.mainImage = [[NSImage alloc] initWithContentsOfURL:url];
  }
}

- (void)setMainImage:(NSImage *)mainImage {
  _mainImage = mainImage;
  _window.aspectRatio = _mainImage.size;
  _mainImageView.image = _mainImage;
  [_window setFrame:NSMakeRect(_window.frame.origin.x,
                               _window.frame.origin.x,
                               _mainImage.size.width,
                               _mainImage.size.height)
            display:YES];
}

@end
