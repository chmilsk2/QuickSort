//
//  QuickSorter.m
//  Quick Sort
//
//  Created by Troy Chmieleski on 8/13/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "QuickSorter.h"
#import "Quick Sort/QuickSort.h"

static QuickSorter *object = nil;

@interface QuickSorter ()

@end

@implementation QuickSorter

- (instancetype)init {
	self = [super init];
	
	if (self) {
		object = self;
	}
	
	return self;
}

- (NSArray *)sort:(NSArray *)input {
	if (!input) {
		return input;
	}
	
	int inputCount = input.count;
	int cIntArray[inputCount];
	[self populateCIntArray:cIntArray withIntArray:input];
	quickSort(cIntArray, inputCount, QuickSortPartitionTypeLumato, QuickSortPartitionOptionRandom);
	NSArray *output = [self intArrayFromCIntArray:cIntArray count:inputCount];
	
	return output;
}

- (void)populateCIntArray:(int[])cIntArray withIntArray:(NSArray *)intArray {
	[intArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		NSNumber *number = (NSNumber *)obj;
		int integer = number.intValue;
		cIntArray[idx] = integer;
	}];
}
					   
- (NSArray *)intArrayFromCIntArray:(int[])cIntArray count:(int)count {
	NSMutableArray *intArray = [NSMutableArray arrayWithCapacity:count];
	
	for (NSUInteger i = 0; i < count; i++) {
		int integer = cIntArray[i];
		[intArray addObject:@(integer)];
	}
	
	return [intArray copy];
}

- (void)printQuickSortBenchmarks:(NSInteger)numberOfComparisons type:(QuickSortPartitionType)type option:(QuickSortPartitionOption)option {
	NSString *quickSortCompletionMessage = [self quickSortCompletionMessageWithNumberOfComparisons:numberOfComparisons type:type option:option];
	NSLog(@"%@", quickSortCompletionMessage);
}

- (NSString *)quickSortCompletionMessageWithNumberOfComparisons:(NSInteger)numberOfComparisons type:(QuickSortPartitionType)type option:(QuickSortPartitionOption)option {
	NSMutableString *quickSortCompletionMessage = [NSMutableString stringWithString:@"Quick sort "];
	[quickSortCompletionMessage appendString:[self quickSortPartitionTypeMessageWithType:type]];
	[quickSortCompletionMessage appendString:[self quickSortOptionMessageWithOption:option]];
	[quickSortCompletionMessage appendString:[NSString stringWithFormat:@"completed in %d comparisons", numberOfComparisons]];
	
	return [quickSortCompletionMessage copy];
}

- (NSString *)quickSortPartitionTypeMessageWithType:(QuickSortPartitionType)type {
	NSString *quickSortPartitionTypeMessage;
	NSString *partitionTypeString;
	
	if (type == QuickSortPartitionTypeHoare) {
		partitionTypeString = @"Hoare";
	}
	
	else if (type == QuickSortPartitionTypeLumato) {
		partitionTypeString = @"Lumato";
	}
	
	quickSortPartitionTypeMessage = [NSString stringWithFormat:@"using %@ partition ", partitionTypeString];
	
	return quickSortPartitionTypeMessage;
}

- (NSString *)quickSortOptionMessageWithOption:(QuickSortPartitionOption)option {
	NSString *quickSortOptionMessage = @"";
	
	if (option == QuickSortPartitionOptionRandom) {
		quickSortOptionMessage = @"with random pivot selection ";
	}
	
	return quickSortOptionMessage;
}

void quickSortCompletion(int *numberOfComparisons, QuickSortPartitionType type, QuickSortPartitionOption option) {
	[object printQuickSortBenchmarks:*numberOfComparisons type:type option:option];
}

@end
