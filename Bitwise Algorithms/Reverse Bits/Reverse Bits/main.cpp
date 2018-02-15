//
//  main.cpp
//  Reverse Bits
//
//  Created by Andrey Ermoshin on 15/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

#include <iostream>

// https://www.geeksforgeeks.org/write-an-efficient-c-program-to-reverse-bits-of-a-number/

// Reverse bits of a given 32 bits unsigned integer.

// For example, given input 43261596 (represented in binary as 00000010100101000001111010011100),
// return 964176192 (represented in binary as 00111001011110000010100101000000).

// On a machine with size of unsigned
// bit as 32. Reverse of 0....001 is
// 100....0.

class Solution {
public:
    uint32_t reverseBits(uint32_t n) {
        int length = sizeof(uint32_t) * 8;
        uint32_t pointer = 1;
        uint32_t result = 0;
        for (int i = 0; i < length; i++) {
            // will be negative after middle
            // so, need to use signed integer
            int mirroredI = length - 1 - 2 * i;
            if (mirroredI > 0) {
                result |= ((n & pointer) << mirroredI);
            }
            else {
                result |= ((n & pointer) >> -mirroredI);
            }
            
            pointer = pointer << 1;
        }
        return result;
    }
};


int main(int argc, const char * argv[]) {
    Solution solver;
    std::cout << "Reverse of 43261596 - " << solver.reverseBits(43261596) << "\n"; // 964176192
    // input: 00000010100101000001111010011100
    // outpu: 00111001011110000010100101000000
    std::cout << "Reverse of 1 - " << solver.reverseBits(1) << "\n"; // 2147483648

    return 0;
}
