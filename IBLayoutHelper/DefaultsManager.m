//
//  DefaultsManager.m
//  Martin
//
//  Created by Tomislav Grbin on 12/27/12.
//
//

#import "DefaultsManager.h"

@implementation DefaultsManager

static NSDictionary *defaultValues;

+ (void)initialize {
  defaultValues = @{
    @(kDefaultsKeyGlobalShortcuts): @{},
    @(kDefaultsKeyMainWindowAlpha): @0.7
  };
}

+ (id)objectForKey:(DefaultsKey)key {
  id o = [[NSUserDefaults standardUserDefaults] objectForKey:[self stringForKey:key]];
  if (o == nil) return defaultValues[@(key)];
  return o;
}

+ (void)setObject:(id)o forKey:(DefaultsKey)key {
  if (o == nil) [[NSUserDefaults standardUserDefaults] removeObjectForKey:[self stringForKey:key]];
  else {
    [[NSUserDefaults standardUserDefaults] setObject:o forKey:[self stringForKey:key]];
    [[NSUserDefaults standardUserDefaults] synchronize];
  }
}

+ (NSString *)stringForKey:(DefaultsKey)key {
  return [NSString stringWithFormat:@"IBLayoutHelper_%d", key];
}

@end
