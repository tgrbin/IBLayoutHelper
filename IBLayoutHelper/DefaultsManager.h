//
//  DefaultsManager.h
//  Martin
//
//  Created by Tomislav Grbin on 12/27/12.
//
//

#import <Foundation/Foundation.h>

@interface DefaultsManager : NSObject

typedef enum {
  kDefaultsKeyGlobalShortcuts,
  kDefaultsKeyMainWindowAlpha
} DefaultsKey;

+ (id)objectForKey:(DefaultsKey)key;
+ (void)setObject:(id)o forKey:(DefaultsKey)key;

@end
