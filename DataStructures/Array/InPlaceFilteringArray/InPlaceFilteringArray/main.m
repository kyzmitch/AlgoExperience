//
//  main.m
//  InPlaceFilteringArray
//
//  Created by Andrei Ermoshin on 07/09/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableArray+Filtering.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Filtering");

        NSMutableArray *arr = [@[@3, @4, @101, @233, @14] mutableCopy];
        NSMutableString *output = [NSMutableString new];
        for (NSNumber *num in arr) {
            [output appendFormat:@"%ld, ", (long)num.integerValue];
        }
        NSLog(@"before: %@", output);

        [arr filterArrayPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if (![obj isKindOfClass:[NSNumber class]]) {
                return NO;
            }
            NSNumber *num = (NSNumber *)obj;
            if (num.unsignedIntegerValue % 2 == 0) {
                return YES;
            } else {
                return NO;
            }
        }];

        output = @"".mutableCopy;
        for (NSNumber *num in arr) {
            [output appendFormat:@"%ld, ", (long)num.integerValue];
        }
        NSLog(@"after: %@", output);
    }
    return 0;
}
