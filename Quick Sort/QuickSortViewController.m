//
//  QuickSortViewController.m
//  Quick Sort
//
//  Created by Troy Chmieleski on 8/13/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import "QuickSortViewController.h"
#import "QuickSorter.h"

@implementation QuickSortViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	NSArray *input = [self inputIntegerArray];
	[self printIntegerArray:input];
	QuickSorter *quickSorter = [QuickSorter new];
	NSArray *output = [quickSorter sort:input];
	[self printIntegerArray:output];
}

- (NSArray *)inputIntegerArray {
	NSMutableArray *inputIntegerArray = [NSMutableArray array];
	
	NSInteger count = 100;
	
	for (int i = count; i >= 0; i--) {
		[inputIntegerArray addObject:@(i)];
	}
	
	//[inputIntegerArray removeAllObjects];
	//[inputIntegerArray addObjectsFromArray:@[@(2), @(1), @(2)]];
	
	return [inputIntegerArray copy];
}

- (void)printIntegerArray:(NSArray *)integerArray {
	NSMutableString *integerArrayString = [NSMutableString string];
	
	NSInteger index = 0;
	
	for (NSNumber *number in integerArray) {
		[integerArrayString appendString:[NSString stringWithFormat:@"%d", number.integerValue]];
		
		if (index != integerArray.count - 1) {
			[integerArrayString appendString:@", "];
		}
		
		index++;
	}
	
	NSLog(@"%@", integerArrayString);
}

@end
