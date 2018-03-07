//
//  main.m
//  Check sender
//
//  Created by Andrey Ermoshin on 07/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface A: NSObject

- (int)getTest;

@end

@implementation A

- (int)getTest {
    return 100;
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        A *a = [[A alloc] init];
        int output1 = [a getTest];
        NSLog(@"output1 = %d", output1);
        a = nil;
        int output2 = [a getTest];
        NSLog(@"output2 = %d", output2);
        // if sender is nil then method will not be called
        // and variable will be initialized with nil?
        output2 = 200;
        NSLog(@"output3 = %d", output2);
        output2 = [a getTest];
        NSLog(@"output4 = %d", output2);
        // yes, with a nil which is auto converted to 0 = (Int)nil
    }
    return 0;
}
