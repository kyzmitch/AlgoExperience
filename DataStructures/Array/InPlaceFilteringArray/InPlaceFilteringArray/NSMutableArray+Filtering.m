//
//  NSMutableArray+Filtering.m
//  InPlaceFilteringArray
//
//  Created by Andrei Ermoshin on 07/09/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

#import "NSMutableArray+Filtering.h"
// very similar to "Move Zeroes" task
// https://github.com/kyzmitch/Algorithms-Experience/blob/master/Sorting/Move%20Zeroes/Move%20Zeroes/main.swift

@implementation NSMutableArray (Filtering)

- (void)filterArrayPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate {
    NSUInteger length = self.count;
    BOOL stop = NO;
    NSUInteger lastValidObjectIndex = 0;
    for (NSUInteger ix = 0; ix < length; ix++) {
        id object = self[ix];
        BOOL needAddObject = predicate(object, ix, &stop);
        if (needAddObject) {
            self[lastValidObjectIndex] = object;
            lastValidObjectIndex += 1;
        }
    }

    if (lastValidObjectIndex == length - 1) {
        return;
    }
    NSRange range = NSMakeRange(lastValidObjectIndex, length - lastValidObjectIndex);
    [self removeObjectsInRange:range];
}

@end
