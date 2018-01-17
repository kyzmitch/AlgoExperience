//
//  main.m
//  Blocks
//
//  Created by admin on 17/01/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

#import <Foundation/Foundation.h>

// https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/WorkingwithBlocks/WorkingwithBlocks.html

NSString *globalBlockKey = @"globalBlockKey";
NSString *blockWithLocalVarKey = @"blockWithLocalVarKey";
NSString *blockWithLiveVarKey = @"blockWithLiveVarKey";
NSString *blockWithStackVarKey = @"blockWithStackVarKey";

NSMutableDictionary * generate() {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    NSNumber *y = @200;
    if (YES) {
        // __NSGlobalBlock__ added
        // https://stackoverflow.com/questions/29138936/in-the-arc-block-in-what-circumstance-is-nsmallocblock-or-nsstackblock#29160233
        // Blocks that don't capture any variables are global blocks.
        // Since all instances of the block are the same, the compiler
        // can just allocate one copy statically for the life of the program.
        [dictionary setObject:^{ printf("hey hey\n"); } forKey:globalBlockKey];
        NSNumber *x = @100;
        // __NSMallocBlock__
        [dictionary setObject:^{ printf("hey x %ld\n", x.longValue); } forKey:blockWithLocalVarKey];
        [dictionary setObject:^{ printf("hey y %ld\n", y.longValue); } forKey:blockWithLiveVarKey];
        long z = 300;
        [dictionary setObject:^{ printf("hey z %ld\n", z); } forKey:blockWithStackVarKey];
    }
    
    return dictionary;
}

typedef void(^BasicBlock)(void);
void mutatingFunc(BOOL condition, BasicBlock block) {
    if (condition) {
        block = ^{NSLog(@"condition");};
    }
    else {
        block = ^{NSLog(@"not a condition");};
    }
    // __PRETTY_FUNCTION__
    NSLog(@"not expected: %@", block);
}

BasicBlock mutatingFuncPossibleFix(BOOL condition, BasicBlock block) {
    NSNumber *x = @100;
    if (condition) {
        block = ^{NSLog(@"condition %@", x);};
    }
    else {
        block = ^{NSLog(@"not a condition %@", x);};
    }
    BasicBlock copiedBlock = [block copy];
    NSLog(@"fixed 1: %@", copiedBlock);
    return block;
}

void fixedFunc(BOOL condition, BasicBlock *block) {
    NSNumber *x = @200;
    if (condition) {
        *block = ^{NSLog(@"condition %@", x);};
    }
    else {
        *block = ^{NSLog(@"not a condition %@", x);};
    }
    NSLog(@"Stored in : %@", *block);
}

void fixedFuncWithCopy(BOOL condition, BasicBlock *block) {
    BasicBlock bl;
    if (condition) {
        bl = ^{NSLog(@"condition");};
    }
    else {
        bl = ^{NSLog(@"not a condition");};
    }
    *block = [bl copy];
    NSLog(@"Stored in after copy : %@", *block);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        void (^block)(void);
        NSLog(@"First test with single block.");
        NSNumber *x = @1;
        if(x) {
            block = ^{ printf("%ld\n", x.longValue); };
        }
        else {
            block = ^{ printf("not %ld\n", x.longValue); };
        }
        block();
        
        NSLog(@"Next test with array of blocks.");
        const unsigned char blocksAmount = 3;
        void (^blo[blocksAmount])(void);
        
        int i = -1;
        while(++i < blocksAmount)
            blo[i] = ^{ printf("%d\n", i); };
        for(i = 0; i < blocksAmount; i++)
            blo[i]();
        
        /*
         // Incorrect:
         typedef void(^BasicBlock)(void);
         void someFunction() {
            BasicBlock block;
            if(condition) {
                block = ^ { ... };
            } else {
                block = ^ { ... };
            }
            ...
         }
         
         // Basically equivalent of:
         void someFunction() {
            BasicBlock block;
            if(condition) {
                struct Block_literal_1 blockStorage = ...;
                block = &blockStorage;
            } // blockStorage falls off the stack here
            else
            {
                struct Block_literal_1 blockStorage = ...;
                block = &blockStorage;
            } // blockStorage falls off the stack here
            // and block thus points to "non-existing"/invalid memory
            ...
         }
         */
        
        NSLog(@"Test of block in dictionary.");
        // objects for keys should be retained
        // and keys always passed by copy.
        NSMutableDictionary *dictionary = generate();
        void (^block1)(void) = [dictionary objectForKey:globalBlockKey];
        NSLog(@"1st: %@", block1);
        void (^block2)(void) = [dictionary objectForKey:blockWithLocalVarKey];
        NSLog(@"2nd: %@", block2);
        void (^block3)(void) = [dictionary objectForKey:blockWithLiveVarKey];
        NSLog(@"2nd: %@", block3);
        void (^block4)(void) = [dictionary objectForKey:blockWithStackVarKey];
        NSLog(@"2nd: %@", block4);
        block1();
        block2();
        block3();
        block4();
        
        NSLog(@"Mutating test.");
        BasicBlock bl;
        mutatingFunc(NO, bl);
        bl = mutatingFuncPossibleFix(NO, bl);
        NSLog(@"passed as return value: %@", bl);
        bl();
        BasicBlock bl2;
        fixedFunc(YES, &bl2);
        NSLog(@"passed by reference: %@", bl2);
        bl2();
        BasicBlock bl3;
        fixedFuncWithCopy(YES, &bl3);
        NSLog(@"passed by reference as copy: %@", bl3);
        bl3();
        
        
        // https://stackoverflow.com/questions/19201405/why-does-arc-copy-this-block-to-the-heap
        int iii = 10;
        int (^aBlock)(void) = ^ {
            return i;
        };
        NSLog(@"Class: %@", [aBlock class]); // by default if you assigning block to variable it is __strong
        NSLog(@"Class: %@", [^int{return iii;} class]); // __NSStackBlock__
    }
    return 0;
}
