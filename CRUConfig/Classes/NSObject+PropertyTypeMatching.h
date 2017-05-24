//
//  NSObject+PropertyTypeMatching.h
//  Pods
//
//  Created by Michael Harrison on 5/8/17.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (PropertyTypeMatching)

+ (NSString * _Nonnull)timeZone;
+ (NSString * _Nonnull)dateFormat;
- (id _Nullable)convertValue:(id _Nullable)value toTypeOfPropertyWithName:(NSString * _Nonnull)propertyName;

@end
