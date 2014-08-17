//
//  RandomIntegerArrayGenerator.m
//  Quick Sort
//
//  Created by Troy Chmieleski on 8/13/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "RandomIntegerArrayGenerator.h"

@implementation RandomIntegerArrayGenerator

+ (void)writeRandomIntegerArrayWithUpperBound:(u_int32_t)upperBound count:(NSInteger)count toFileName:(NSString *)fileName {
	NSArray *randomIntegerArray = [self randomIntegerArrayWithUpperBound:upperBound count:count];
	NSString *randomIntegerArrayString = [self randomIntegerArrayStringFromRandomIntegerArray:randomIntegerArray];
	[self writeString:randomIntegerArrayString toFileWithName:fileName];
}

+ (NSArray *)randomIntegerArrayWithUpperBound:(u_int32_t)upperBound count:(NSInteger)count {
	NSMutableArray *randomIntegerArray = [NSMutableArray arrayWithCapacity:count];
	
	for (NSInteger i = 0; i < count; i++) {
		int randomInteger = arc4random_uniform(upperBound);
		[randomIntegerArray addObject:@(randomInteger)];
	}
	
	return [randomIntegerArray copy];
}

+ (NSString *)randomIntegerArrayStringFromRandomIntegerArray:(NSArray *)randomIntegerArray {
	NSMutableString *randomIntegerString = [[NSMutableString alloc] init];
	
	NSUInteger index = 0;
	
	for (NSNumber *randomIntegerNumber in randomIntegerArray) {
		[randomIntegerString appendString:[NSString stringWithFormat:@"%d", randomIntegerNumber.intValue]];
		
		if (index < randomIntegerArray.count - 1) {
			[randomIntegerString appendString:@","];
		}
		
		index++;
	}
	
	return [randomIntegerString copy];
}

+ (void)writeString:(NSString *)string toFileWithName:(NSString *)fileName {
	NSError *error;
	NSString *path = [self pathForFileName:fileName];
	[string writeToFile:path atomically:YES encoding:NSStringEncodingConversionAllowLossy error:&error];
}

+ (NSArray *)randomIntegerArrayWithFileName:(NSString *)fileName {
	NSError *error;
	NSString *path = [self pathForFileName:fileName];
	NSString *content = [NSString stringWithContentsOfFile:path encoding:NSStringEncodingConversionAllowLossy error:&error];
	
	NSMutableArray *randomIntegerArray = [NSMutableArray array];
	
	NSError *e;
	NSRegularExpression *integerArrayExpression = [[NSRegularExpression alloc] initWithPattern:@"[^, ]+" options:NSRegularExpressionCaseInsensitive error:&e];
	[integerArrayExpression enumerateMatchesInString:content options:NSMatchingReportCompletion range:NSMakeRange(0, content.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
		NSString *integerString = [content substringWithRange:result.range];
		
		if (integerString.length > 0) {
			[randomIntegerArray addObject:@(integerString.integerValue)];
		}
	}];
	
	return [randomIntegerArray copy];
}

+ (NSString *)pathForFileName:(NSString *)fileName {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[fileName stringByAppendingString:@".txt"]];
	
	return filePath;
}

@end
