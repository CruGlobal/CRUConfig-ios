//
//  NSString+transformations.m
//  Pods
//
//  Created by Michael Harrison on 5/8/17.
//
//

#import "NSString+CaseTransformations.h"

@implementation NSString (CaseTransformations)

- (NSString *)snakeCaseToCamelCase {
    
    NSArray<NSString *> *components = [self componentsSeparatedByString:@"_"];
    NSMutableArray<NSString *> *camelCaseComponents = @[].mutableCopy;
    
    if (components.count <= 1) {
        return self;
    }
    
    [components enumerateObjectsUsingBlock:^(NSString * _Nonnull component, NSUInteger index, BOOL * _Nonnull stop) {
        if (component.capitalizedString) {
            [camelCaseComponents addObject:component.capitalizedString];
        }
    }];
    
    if (camelCaseComponents.count > 0 && components[0].lowercaseString) {
        camelCaseComponents[0] = components[0].lowercaseString;
    } else if (camelCaseComponents.count > 0) {
        camelCaseComponents[0] = components[0];
    }
    
    return [camelCaseComponents componentsJoinedByString:@""];
}
    
@end
