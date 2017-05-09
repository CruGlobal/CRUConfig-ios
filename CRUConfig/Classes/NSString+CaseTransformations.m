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
    if (components.count <= 1) {
        return self;
    }
    
    return self;
}
    
@end
