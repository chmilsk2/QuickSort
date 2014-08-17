//
//  QuickSort.h
//  Quick Sort
//
//  Created by Troy Chmieleski on 8/13/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

/**
 Partition algorithm type
 */
typedef enum {
	QuickSortPartitionTypeHoare = 0,
	QuickSortPartitionTypeLumato
} QuickSortPartitionType;

/**
 Partition algorithm option
 */
typedef enum {
	QuickSortPartitionOptionNone = 0,
	QuickSortPartitionOptionRandom
} QuickSortPartitionOption;

/**
 *  Sorts an input array of integers using the quick sort algorithm
 *
 *  Quick sort employs a "divide and conquer" strategy. It splits the array in two subarrays based on a pivot. Then the subarrays are sorted recursively. One subarray consists of elements less than the pivot and the other subarray consists of items greater than the pivot. It is an in place aglorithm since it can sort the array without using any extra space.
 *
 *  Time complexity
 *
 *  The number of comparisons made is a good approximation for the time complexity
 *
 *  Best: O(n log(n))
 *  Average: O(n log(n))
 *  Worst: O(n^2)
 *
 *  Common worst case scenarios:
 *
 *  1. All elements of array are the same
 *  2. Array is already sorted in same order
 *  3. Array is already sorted in reverse order
 *
 *  Space complexity
 *
 *  Worst: O(n)
 *
 *
 *  @param input Input array of integers
 *  @param count Number of elements in the input array
 *  @param type Partition algorithm type
 *  @param option Partition option
 */
void quickSort(int input[], int count, QuickSortPartitionType type, QuickSortPartitionOption option);

/**
 *  Completion callback fired when quick sort has completed.
 *
 *  @param numberOfComparisons Pointer to the number of comparisons made while sorting
 *  @param type Partition algorithm type
 *  @param option Partition algorithm option
 */
void quickSortCompletion(int *numberOfComparisons, QuickSortPartitionType type, QuickSortPartitionOption option);