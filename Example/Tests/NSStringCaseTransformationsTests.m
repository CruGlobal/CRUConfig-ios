//
//  CRUConfigTests.m
//  CRUConfigTests
//
//  Created by Harro on 04/25/2016.
//  Copyright (c) 2016 Harro. All rights reserved.
//

// https://github.com/Specta/Specta

#import <CRUConfig/NSString+CaseTransformations.h>

SpecBegin(NSStringCaseTransformationsSpecs)

describe(@"string transformations from snake case to camel case", ^{
    
    it(@"will succeed with snake case string", ^{
        expect(@"my_snake_case_string".snakeCaseToCamelCase).to.equal(@"mySnakeCaseString");
    });
    
    it(@"will return and empty string if given empty string", ^{
        expect(@"".snakeCaseToCamelCase).to.equal(@"");
    });
    
    it(@"will return a camel case string if given a camel case string", ^{
        expect(@"mySnakeCaseString".snakeCaseToCamelCase).to.equal(@"mySnakeCaseString");
    });
    
    it(@"will fail with lowercase string", ^{
        expect(@"mysnakecasestring".snakeCaseToCamelCase).toNot.equal(@"mySnakeCaseString");
    });
    
});

SpecEnd

