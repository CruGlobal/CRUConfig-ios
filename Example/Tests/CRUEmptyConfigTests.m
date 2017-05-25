//
//  CRUEmptyConfigTests.m
//  CRUConfig
//
//  Created by Michael Harrison on 5/24/17.
//  Copyright © 2017 Harro. All rights reserved.
//

#import "CRUEmptyConfigTest.h"
#import <CRUConfig/CRUConfig+setter.h>
#import <CRUConfig/NSObject+PropertyTypeMatching.h>

SpecBegin(CRUEmptyConfigSpecs)

describe(@"CRUEmptyConfig", ^{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = [NSObject dateFormat];
    __block NSDate *regularTestDate = [dateFormatter dateFromString:@"2017-05-24 19:46:02 UTC"];
    __block NSData *regularTestData = [@"my amazing data blob" dataUsingEncoding:NSUTF8StringEncoding];
    
    it(@"will load values into properties from file without conversion", ^{
        NSString *configFilePath = [[NSBundle bundleForClass:[CRUEmptyConfigTest class]] pathForResource:@"test" ofType:@"plist"];
        NSDictionary *configDictionary	= [NSDictionary dictionaryWithContentsOfFile:configFilePath] ?: @{};
        CRUEmptyConfigTest *testConfig = [[CRUEmptyConfigTest alloc] init];
        [testConfig setPropertiesWithContentsOfConfigDictionary:configDictionary];
        expect(testConfig.numberArray).to.equal(@[@1, @(-1)]);
        expect(testConfig.directionDictionary[@"negative"]).to.equal(@"-1");
        expect(testConfig.directionDictionary[@"positive"]).to.equal(@"1");
        expect(testConfig.myBoolean).to.equal(@1);
        expect(testConfig.DATAINTHEHOUSE).to.equal(regularTestData);
        expect(testConfig.date).to.equal(regularTestDate);
        expect(testConfig.medium_number).to.equal(@87342345);
        expect(testConfig.myAmazingString).to.equal(@"my amazing string");
        expect(testConfig.my_amazing_string).to.beNil();
    });
    
});

SpecEnd
