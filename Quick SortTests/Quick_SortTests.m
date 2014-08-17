//
//  Quick_SortTests.m
//  Quick SortTests
//
//  Created by Troy Chmieleski on 8/13/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QuickSorter.h"
#import "RandomIntegerArrayGenerator.h"

@interface Quick_SortTests : XCTestCase

@end

@implementation Quick_SortTests {
	NSSortDescriptor *_sortDescriptor;
	QuickSorter *_quickSorter;
}

- (void)setUp {
    [super setUp];

	_sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
	_quickSorter = [QuickSorter new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSortNilInputReturnsNilOutput {
	NSArray *input;
	NSArray *output = [_quickSorter sort:input];
	XCTAssertNil(output, @"output is not nil");
}

- (void)testSortWithEmptyInputReturnsEmptyOutput {
	NSArray *input = @[];
	NSArray *output = [_quickSorter sort:input];
	XCTAssertEqualObjects(input, output, @"output array is not empty");
}

- (void)testSortAlreadySortedInputReturnsInput {
	NSArray *input = @[@1, @2, @3];
	NSArray *output = [_quickSorter sort:input];
	XCTAssertEqualObjects(input, output, @"output array does not equal input array");
}

- (void)testSortWithAllIntegersEqual {
	NSArray *input = @[@3, @3, @3, @3, @3];
	[self sortWithInput:input];
}

- (void)testSortWithRepeatedIntegers {
	NSArray *input = @[@5,@9,@10,@9, @5];
	[self sortWithInput:input];
}

- (void)testEasySortWithReverseInput {
	NSArray *input = @[@4, @3, @2, @1];
	[self sortWithInput:input];
}

- (void)testEasyNegativeSort {
	NSArray *input = @[@(-3), @(-1), @(-2)];
	[self sortWithInput:input];
}

- (void)testSortThatRequiresOnlyOneForwardPassAndMaxOfOneSwapPerPair {
	NSArray *input = @[@3, @1, @2];
	[self sortWithInput:input];
}

- (void)testEasySortWithEvenLengthInput {
	NSArray *input = @[@100, @3000, @1, @(-40)];
	[self sortWithInput:input];
}

- (void)testMediumSortWithEvenLengthInput {
	NSArray *input;
	[self sortWithInput:input];
}

- (void)testHardSortWithEvenLengthInput {
	NSArray *input;
	[self sortWithInput:input];
}

- (void)testExtraHardSortWithEvenLengthInput {
	NSArray *input = [self extraHardInputWithEvenLength];
	[self sortWithInput:input];
}

- (void)testNSArrayExtraHardSortWithEvenLengthInput {
	NSArray *input = [self extraHardInputWithEvenLength];
	NSArray *output = [self NSArraySort:input];
	
	XCTAssertEqualObjects(output, output, @"sorted output does not match expected output");
}

- (NSArray *)extraHardInputWithEvenLength {
	NSString *fileName = @"extraHardSortWithEvenLengthInput";
	//[RandomIntegerArrayGenerator writeRandomIntegerArrayWithUpperBound:10000 count:10000 toFileName:fileName];
	NSArray *input = [RandomIntegerArrayGenerator randomIntegerArrayWithFileName:fileName];
	
	return input;
}

- (void)testEasySortWithOddLengthInput {
	NSArray *input = @[@2, @3, @1];
	[self sortWithInput:input];
}

- (void)testMediumSortWithOddLengthInput {
	NSArray *input = @[@3, @5, @1, @4, @2];
	[self sortWithInput:input];
}

- (void)testHardSortWithOddLengthInput {
	NSArray *input = @[];
	[self sortWithInput:input];
}

- (void)sortWithInput:(NSArray *)input {
	__block NSArray *output;
	
	[self measureBlock:^{
		output = [_quickSorter sort:input];
	}];

	[self sortWithInput:input Output:output];
}

- (void)sortWithInput:(NSArray *)input Output:(NSArray *)output {
	NSArray *expectedOutput = [self expectedSort:input];
	XCTAssertEqualObjects(output, expectedOutput, @"sorted output array does not matched expected sorted output array");
}

- (NSArray *)NSArraySort:(NSArray *)input {
	__block NSArray *output;
	
	[self measureBlock:^{
		[self expectedSort:input];
	}];
	
	return output;
}

- (NSArray *)expectedSort:(NSArray *)input {
	NSArray *expectedOutput = [input sortedArrayUsingDescriptors:@[_sortDescriptor]];
	
	return expectedOutput;
}

@end
