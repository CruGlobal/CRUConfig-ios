//
//  NSObject+PropertyTypeMatching.m
//  Pods
//
//  Created by Michael Harrison on 5/8/17.
//
//

#import "NSObject+PropertyTypeMatching.h"
#import <objc/runtime.h>

@implementation NSObject (PropertyTypeMatching)

- (id)convertValue:(id)value toTypeMatchingPropertyWithName:(NSString * _Nonnull)propertyName {
    
    if (!value) {
        return nil;
    }
    
    objc_property_t property = class_getProperty(self.class, [propertyName UTF8String]);
    if (property == NULL) {
        return nil;
    }
    
    const char *attributesCString = property_getAttributes(property);
    if (attributesCString == NULL) {
        return nil;
    }
    
    Class type = [[self class] typeFromAttributesString:attributesCString];
    if (!type) {
        return nil;
    }
    
    if ([value isKindOfClass:[NSNumber class]]) {
        return [[self class] convertNumber:value toMatchType:type];
    } else if ([value isKindOfClass:[NSData class]]) {
        return [[self class] convertData:value toMatchType:type];
    } else if ([value isKindOfClass:[NSDate class]]) {
        return [[self class] convertDate:value toMatchType:type];
    } else if ([value isKindOfClass:[NSString class]]) {
        return [[self class] convertString:value toMatchType:type];
    } else if ([value isKindOfClass:[NSArray class]]) {
        return [[self class] convertArray:value toMatchType:type];
    } else if ([value isKindOfClass:[NSDictionary class]]) {
        return [[self class] convertDictionary:value toMatchType:type];
    } else {
        return nil;
    }
}

+ (Class)typeFromAttributesString:(const char *)attributesCString {
    
    NSString *attributesString = [[NSString alloc] initWithUTF8String:attributesCString];
    NSArray *components = [attributesString componentsSeparatedByString:@","];
    NSString *typeString = components.firstObject;
    NSRange firstQuote = [typeString rangeOfString:@"\""];
    NSInteger charactersAfterFirstQuote = typeString.length - firstQuote.location - 1;
    if (charactersAfterFirstQuote < 0) {
        return nil;
    }
    NSRange secondQuote = [typeString rangeOfString:@"\""
                                            options:NSLiteralSearch
                                              range:NSMakeRange(firstQuote.location + 1, charactersAfterFirstQuote)];
    NSInteger charactersAfterSecondQuote = typeString.length - secondQuote.location;
    if (charactersAfterSecondQuote < 0) {
        return nil;
    }
    typeString = [typeString substringWithRange:NSMakeRange(firstQuote.location + 1,
                                                            charactersAfterFirstQuote - charactersAfterSecondQuote)];
    
    return NSClassFromString(typeString);
}

+ (id)convertNumber:(NSNumber *)number toMatchType:(Class)type {
    if (type == NSNumber.class) {
        return number;
    } else if (type == NSString.class) {
        return number.stringValue;
    } else {
        return nil;
    }
}

+ (id)convertData:(NSData *)data toMatchType:(Class)type {
    if (type == NSData.class) {
        return data;
    } else if (type == NSString.class) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    } else {
        return nil;
    }
}

+ (id)convertDate:(NSDate *)date toMatchType:(Class)type {
    if (type == NSDate.class) {
        return date;
    } else if (type == NSString.class) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        return [dateFormatter stringFromDate:date];
    } else {
        return nil;
    }
}

+ (id)convertString:(NSString *)string toMatchType:(Class)type {
    if (type == NSString.class) {
        return string;
    } else if (type == NSURL.class) {
        return [[NSURL alloc] initWithString:string];
    } else if (type == NSNumber.class) {
        return [[NSNumber alloc] initWithDouble:string.doubleValue];
    }  else if (type == NSDate.class) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        return [dateFormatter dateFromString:string];
    }  else if (type == NSData.class) {
        return [string dataUsingEncoding:NSUTF8StringEncoding];
    } else {
        return nil;
    }
}

+ (id)convertArray:(NSArray *)array toMatchType:(Class)type {
    if (type == NSArray.class) {
        return array;
    } else if (type == NSSet.class) {
        return [NSSet setWithArray:array];
    } else {
        return nil;
    }
}

+ (id)convertDictionary:(NSDictionary *)dictionary toMatchType:(Class)type {
    if (type == NSDictionary.class) {
        return dictionary;
    } else {
        return nil;
    }
}

@end
