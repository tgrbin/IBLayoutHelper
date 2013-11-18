//
//  AppDelegate.m
//  IBLayoutHelper
//
//  Created by Tomislav Grbin on 18/11/13.
//  Copyright (c) 2013 Five Minutes ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "GlobalShortcuts.h"

@interface AppDelegate()
@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSImageView *mainImageView;

@property (nonatomic, strong) NSURL *mainImageURL;
@property (nonatomic, strong) NSImage *mainImage;
@end

@implementation AppDelegate

+ (void)initialize {
  [GlobalShortcuts setupShortcuts];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  _window.alphaValue = 0.7;
}

- (IBAction)openPressed:(id)sender {
  NSOpenPanel *panel = [NSOpenPanel openPanel];
  panel.canChooseDirectories = NO;
  panel.canChooseFiles = YES;
  panel.allowsMultipleSelection = NO;
  panel.allowedFileTypes = [NSImage imageFileTypes];
  panel.title = @"Open";
  
  if ([panel runModal] == NSFileHandlingPanelOKButton) {
    self.mainImageURL = panel.URL;
  }
}

- (void)setMainImageURL:(NSURL *)mainImageURL {
  _mainImageURL = mainImageURL;
  [[NSDocumentController sharedDocumentController] noteNewRecentDocumentURL:mainImageURL];
  self.mainImage = [[NSImage alloc] initWithContentsOfURL:mainImageURL];
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

- (BOOL)application:(NSApplication *)sender openFile:(NSString *)filename {
  self.mainImageURL = [NSURL fileURLWithPath:filename];
  return YES;
}

@end
