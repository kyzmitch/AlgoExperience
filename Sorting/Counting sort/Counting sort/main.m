//
//  main.m
//  Counting sort
//
//  Created by Andrey Ermoshin on 09/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

#import <Foundation/Foundation.h>

// https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html

@interface NSArray (KSorting)

- (nullable NSArray *)k_coutingSorted;

@end

@implementation NSArray (KSorting)

// https://www.geeksforgeeks.org/counting-sort/

- (nullable NSArray *)k_coutingSorted {
    NSUInteger n = [self count];
    if (n < 2) {
        return nil;
    }
    
    // Step 1
    // Create an array to store the count of each element
    int max = 0;
    for (id objectId in self) {
        if (![objectId isKindOfClass:[NSNumber class]]) {
            return  nil;
        }
        
        NSNumber *number = objectId;
        // https://developer.apple.com/documentation/foundation/nsnumber/1807278-objctype
        // Your implementation of objCType must return one of “c”, “C”, “s”, “S”, “i”, “I”, “l”, “L”, “q”, “Q”, “f”, and “d”.
        
        const char *type = [number objCType];
        if (strcmp(type, @encode(int)) == 0) {
            // NSLog(@"this is a int");
        }
        else {
            return nil;
        }
        
        max = MAX(max, number.intValue);
    }
    
    if (max == 0) {
        return nil;
    }
    
    // only C array can be initialized right away
    // NSMutableArray can just be initialized with enought memory
    // but without any values/objects
    size_t cacheSize = sizeof(int) * (max + 1);
    int *cache = malloc(cacheSize);
    memset(cache, 0, cacheSize);
    
    for (NSNumber *number in self) {
        int current = number.intValue;
        cache[current] += 1;
    }
    
    // Step 2
    // Set each value to be the sum of the previous two values
    for (int i = 1; i < max + 1; i++) {
        cache[i] += cache[i - 1];
    }
    
    NSMutableArray *sorted = [self mutableCopy];
    for (NSNumber *number in self) {
        int element = number.intValue;
        cache[element] -= 1;
        sorted[cache[element]] = @(element);
    }
    
    free(cache);
    return sorted;
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *input1 = @[@1, @4, @1, @2, @7, @5, @2];
        NSLog(@"input: %@", input1);
        NSArray *output1 = [input1 k_coutingSorted];
        NSLog(@"output: %@", output1);
    }
    return 0;
}
