//
//  RandomIntegerArrayGenerator.h
//  Quick Sort
//
//  Created by Troy Chmieleski on 8/13/14.
//  Copyright (c) 2014 Troy Chmieleski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RandomIntegerArrayGenerator : UIViewController

+ (void)writeRandomIntegerArrayWithUpperBound:(u_int32_t)upperBound count:(NSInteger)count toFileName:(NSString *)fileName;
+ (NSArray *)randomIntegerArrayWithFileName:(NSString *)path;

@end
