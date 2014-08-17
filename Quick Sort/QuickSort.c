//
//  QuickSort.c
//  Quick Sort
//
//  Created by Troy Chmieleski on 8/13/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include "QuickSort.h"

typedef enum {
	false = 0,
	true = 1
} bool;

void prepareSort(QuickSortPartitionOption option);
void seedRandomNumberGenerator();
void sortSubArray(int input[], int low, int high, QuickSortPartitionType type, QuickSortPartitionOption option, int *numberOfComparisons);
int leftSubArrayUpperBound(int currentUpperBound, QuickSortPartitionType type);
int partition(int input[], int low, int high, QuickSortPartitionType type, QuickSortPartitionOption option, int *numberOfComparisons);
int hoarePartition(int input[], int low, int high, QuickSortPartitionOption option, int *numberOfComparisons);
int hoareSweepRight(int input[], int left, int pivot, int *numberOfComparisons);
int hoareSweepLeft(int input[], int right, int pivot, int *numberOfComparisons);
int lumatoPartition(int input[], int low, int high, QuickSortPartitionOption option, int *numberOfComparisons);
void preparePivot(int input[], int low, int high, int normalPivotIndex, QuickSortPartitionOption option);
int advanceLeftIndex(int left);
int advanceRightIndex(int right);
void swapItemsAtIndices(int input[], int firstIndex, int secondIndex);
bool isRightInputLessThanOrEqualToPivot(int input[], int right, int pivot, int *numberOfComparisons);
bool isLeftInputGreaterThanOrEqualToPivot(int input[], int left, int pivot, int *numberOfComparisons);
void didCompare(int *numberOfComparisons);
bool hasFewerThanTwoItems(int low, int high);
int randomPivotIndex(int low, int high);

void quickSort(int input[], int count, QuickSortPartitionType type, QuickSortPartitionOption option) {
	int low = 0;
	int high = count - 1;
	int numberOfComparisons = 0;
	
	prepareSort(option);
	sortSubArray(input, low, high, type, option, &numberOfComparisons);
	quickSortCompletion(&numberOfComparisons, type, option);
}

void prepareSort(QuickSortPartitionOption option) {
	if (option == QuickSortPartitionOptionRandom) {
		seedRandomNumberGenerator();
	}
}

void seedRandomNumberGenerator() {
	srand(time(NULL));
}

void sortSubArray(int input[], int low, int high, QuickSortPartitionType type, QuickSortPartitionOption option, int *numberOfComparisons) {
	if (hasFewerThanTwoItems(low, high)) {
		return;
	}
	
	int splitPoint = partition(input, low, high, type, option, numberOfComparisons);
	
	int upperBoundForSortingLeftSubArray = leftSubArrayUpperBound(splitPoint, type);
	sortSubArray(input, low, upperBoundForSortingLeftSubArray, type, option, numberOfComparisons);
	sortSubArray(input, splitPoint + 1, high, type, option, numberOfComparisons);
}

int leftSubArrayUpperBound(int currentUpperBound, QuickSortPartitionType type) {
	int upperBound = currentUpperBound - 1;
	
	if (type == QuickSortPartitionTypeHoare) {
		upperBound = currentUpperBound;
	}
	
	return upperBound;
}

int partition(int input[], int low, int high, QuickSortPartitionType type, QuickSortPartitionOption option, int *numberOfComparisons) {
	int splitPoint = 0;
	
	if (type == QuickSortPartitionTypeHoare) {
		splitPoint = hoarePartition(input, low, high, option, numberOfComparisons);
	}
	
	else if (type == QuickSortPartitionTypeLumato) {
		splitPoint = lumatoPartition(input, low, high, option, numberOfComparisons);
	}
	
	return splitPoint;
}

int hoarePartition(int input[], int low, int high, QuickSortPartitionOption option, int *numberOfComparisons) {
	int pivotIndex = low;
	preparePivot(input, low, high, pivotIndex, option);
	int pivot = input[pivotIndex];
	int left = low - 1;
	int right = high + 1;
	
	while (true) {
		right = hoareSweepLeft(input, right, pivot, numberOfComparisons);
		left = hoareSweepRight(input, left, pivot, numberOfComparisons);
		
		if (left < right) {
			swapItemsAtIndices(input, left, right);
		}
		
		else {
			return right;
		}
	}
}

int hoareSweepLeft(int input[], int right, int pivot, int *numberOfComparisons) {
	while (true) {
		right = advanceRightIndex(right);
		
		if (isRightInputLessThanOrEqualToPivot(input, right, pivot, numberOfComparisons)) {
			break;
		}
	}
	
	return right;
}

int hoareSweepRight(int input[], int left, int pivot, int *numberOfComparisons) {
	while (true) {
		left = advanceLeftIndex(left);
		
		if (isLeftInputGreaterThanOrEqualToPivot(input, left, pivot, numberOfComparisons)) {
			break;
		}
	}
	
	return left;
}

int lumatoPartition(int input[], int low, int high, QuickSortPartitionOption option, int *numberOfComparisons) {
	int pivotIndex = high;
	preparePivot(input, low, high, pivotIndex, option);
	int pivot = input[pivotIndex];
	int left = low - 1;
	
	for (int right = low; right <= high - 1; right++) {
		if (isRightInputLessThanOrEqualToPivot(input, right, pivot, numberOfComparisons)) {
			left = advanceLeftIndex(left);
			swapItemsAtIndices(input, left, right);
		}
	}
	
	swapItemsAtIndices(input, left + 1, high);
	
	return left + 1;
}

void preparePivot(int input[], int low, int high, int normalPivotIndex, QuickSortPartitionOption option) {
	if (option == QuickSortPartitionOptionRandom) {
		int pivotIndex = randomPivotIndex(low, high);
		swapItemsAtIndices(input, pivotIndex, normalPivotIndex);
	}
}

bool isRightInputLessThanOrEqualToPivot(int input[], int right, int pivot, int *numberOfComparisons) {
	bool isRightInputLessThanOrEqualToPivot = (input[right] <= pivot) ? true : false;
	didCompare(numberOfComparisons);
	
	return isRightInputLessThanOrEqualToPivot;
}

bool isLeftInputGreaterThanOrEqualToPivot(int input[], int left, int pivot, int *numberOfComparisons) {
	bool isLeftInputGreaterThanOrEqualToPivot = (input[left] >= pivot) ? true : false;
	didCompare(numberOfComparisons);
	
	return isLeftInputGreaterThanOrEqualToPivot;
}

int advanceLeftIndex(int left) {
	left++;
	
	return left;
}

int advanceRightIndex(int right) {
	right--;
	
	return right;
}

void swapItemsAtIndices(int input[], int firstIndex, int secondIndex) {
	int originalFirstItem = input[firstIndex];
	input[firstIndex] = input[secondIndex];
	input[secondIndex] = originalFirstItem;
}

void didCompare(int *numberOfComparisons) {
	(*numberOfComparisons)++;
}

bool hasFewerThanTwoItems(int low, int high) {
	bool hasFewerThanTwoItems = (high - low <= 0) ? true : false;
	
	return hasFewerThanTwoItems;
}

int randomPivotIndex(int low, int high) {
	int randomPivotIndex = low + rand() % (high - low + 1);
	
	return randomPivotIndex;
}