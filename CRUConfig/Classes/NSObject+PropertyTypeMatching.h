//
//  NSObject+PropertyTypeMatching.h
//  Pods
//
//  Created by Michael Harrison on 5/8/17.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (PropertyTypeMatching)

- (id _Nullable)convertValue:(id _Nullable)value toTypeMatchingPropertyWithName:(NSString * _Nonnull)propertyName;

@end
