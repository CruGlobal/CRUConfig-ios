//
//  NSObjectPropertyTypeMatchingTests.m
//  CRUConfig
//
//  Created by Michael Harrison on 5/24/17.
//  Copyright © 2017 Harro. All rights reserved.
//

#import <CRUConfig/NSObject+PropertyTypeMatching.h>

@interface PropertyTest: NSObject

@property (nonatomic, strong) NSArray *arrayProperty;
@property (nonatomic, strong) NSSet *setProperty;
@property (nonatomic, strong) NSDictionary *dictionaryProperty;
@property (nonatomic, strong) NSString *stringProperty;
@property (nonatomic, strong) NSURL *urlProperty;
@property (nonatomic, strong) NSDate *dateProperty;
@property (nonatomic, strong) NSData *dataProperty;
@property (nonatomic, strong) NSNumber *numberProperty;

@end

@implementation PropertyTest

@end

@interface PrimitivePropertyTest: PropertyTest

@property (nonatomic, assign) BOOL booleanProperty;
@property (nonatomic, assign) NSInteger integerProperty;
@property (nonatomic, assign) double doubleProperty;

@end

@implementation PrimitivePropertyTest

@end

SpecBegin(NSObjectPropertyTypeMatchingSpecs)

describe(@"value conversion for edge cases", ^{

    __block PropertyTest *propertyObject = nil;
    __block NSString *regularTestString = @"my-regular-string";
    __block NSNumber *numberTestStringAsNumber = @56;
    
    beforeEach(^{
        propertyObject = [[PropertyTest alloc] init];
    });
    
    it(@"will return nil when converting nil to any property type", ^{
        id convertedValue = [propertyObject convertValue:nil toTypeOfPropertyWithName:@"arrayProperty"];
        expect(convertedValue).to.beNil();
        convertedValue = [propertyObject convertValue:nil toTypeOfPropertyWithName:@"setProperty"];
        expect(convertedValue).to.beNil();
        convertedValue = [propertyObject convertValue:nil toTypeOfPropertyWithName:@"dictionaryProperty"];
        expect(convertedValue).to.beNil();
        convertedValue = [propertyObject convertValue:nil toTypeOfPropertyWithName:@"stringProperty"];
        expect(convertedValue).to.beNil();
        convertedValue = [propertyObject convertValue:nil toTypeOfPropertyWithName:@"urlProperty"];
        expect(convertedValue).to.beNil();
        convertedValue = [propertyObject convertValue:nil toTypeOfPropertyWithName:@"dateProperty"];
        expect(convertedValue).to.beNil();
        convertedValue = [propertyObject convertValue:nil toTypeOfPropertyWithName:@"dataProperty"];
        expect(convertedValue).to.beNil();
        convertedValue = [propertyObject convertValue:nil toTypeOfPropertyWithName:@"numberProperty"];
        expect(convertedValue).to.beNil();
    });
    
    it(@"will return nil when converting a string to a the type of a property that doesn't exist", ^{
        id convertedValue = [propertyObject convertValue:regularTestString toTypeOfPropertyWithName:@"myFakeProperty"];
        expect(convertedValue).to.beNil();
    });
    
    it(@"will return nil when converting any object to property with a primitive type", ^{
        propertyObject = [[PrimitivePropertyTest alloc] init];
        id convertedValue = [propertyObject convertValue:numberTestStringAsNumber toTypeOfPropertyWithName:@"booleanProperty"];
        expect(convertedValue).to.beNil();
        convertedValue = [propertyObject convertValue:numberTestStringAsNumber toTypeOfPropertyWithName:@"integerProperty"];
        expect(convertedValue).to.beNil();
        convertedValue = [propertyObject convertValue:numberTestStringAsNumber toTypeOfPropertyWithName:@"doubleProperty"];
        expect(convertedValue).to.beNil();
    });

});

describe(@"value conversion from NSString", ^{
    
    __block NSString *regularTestString = @"my-regular-string";
    __block NSData *regularTestStringAsData = [regularTestString dataUsingEncoding:NSUTF8StringEncoding];
    __block NSString *urlTestString = @"http://example.com/test";
    __block NSURL *urlTestStringAsUrl = [[NSURL alloc] initWithString:urlTestString];
    __block NSString *numberTestString = @"56";
    __block NSNumber *numberTestStringAsNumber = @56;
    __block NSString *dateTestString = @"2017-05-24 15:31:29 UTC";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = [NSObject dateFormat];
    __block NSDate *dateTestStringAsDate = [dateFormatter dateFromString:dateTestString];
    __block PropertyTest *propertyObject = nil;
    
    beforeEach(^{
        propertyObject = [[PropertyTest alloc] init];
    });
    
    it(@"will succeed when converting a regular string for property of type NSString", ^{
        expect([propertyObject convertValue:regularTestString toTypeOfPropertyWithName:@"stringProperty"]).to.equal(regularTestString);
    });
    
    it(@"will succeed when converting a url string for property of type NSURL", ^{
        id convertedUrl = [propertyObject convertValue:urlTestString toTypeOfPropertyWithName:@"urlProperty"];
        expect(convertedUrl).to.beKindOf([NSURL class]);
        expect(convertedUrl).to.equal(urlTestStringAsUrl);
        expect(((NSURL *)convertedUrl).absoluteString).to.equal(urlTestString);
    });
    
    it(@"will succeed when converting a date string for property of type NSDate", ^{
        id convertedDate = [propertyObject convertValue:dateTestString toTypeOfPropertyWithName:@"dateProperty"];
        expect(convertedDate).to.beKindOf([NSDate class]);
        expect(convertedDate).to.equal(dateTestStringAsDate);
    });
    
    it(@"will return nil when converting a regular string for property of type NSDate", ^{
        id convertedDate = [propertyObject convertValue:regularTestString toTypeOfPropertyWithName:@"dateProperty"];
        expect(convertedDate).to.beNil();
    });
    
    it(@"will succeed when converting a regular string for property of type NSData", ^{
        id convertedData = [propertyObject convertValue:regularTestString toTypeOfPropertyWithName:@"dataProperty"];
        expect(convertedData).to.equal(regularTestStringAsData);
    });
    
    it(@"will succeed when converting a number string for property of type NSNumber", ^{
        id convertedNumber = [propertyObject convertValue:numberTestString toTypeOfPropertyWithName:@"numberProperty"];
        expect(convertedNumber).to.beKindOf([NSNumber class]);
        expect(convertedNumber).to.equal(numberTestStringAsNumber);
    });
});

SpecEnd
