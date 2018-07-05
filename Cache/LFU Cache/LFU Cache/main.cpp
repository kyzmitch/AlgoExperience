//
//  main.cpp
//  LFU Cache
//
//  Created by Andrei Ermoshin on 04/07/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

#include <iostream>
#include "LFUCache.hpp"

int main(int argc, const char * argv[]) {
    LFUCache cache(2 /* capacity */);
    
    cache.put(1, 1);
    cache.put(2, 2);
    std::cout << cache.get(1) << std::endl; // returns 1
    cache.put(3, 3);    // evicts key 2
    
    std::cout << cache.get(2) << std::endl; // returns -1 (not found)
    std::cout << cache.get(3) << std::endl; // returns 3.
    cache.put(4, 4);    // evicts key 1.
    
    std::cout << cache.get(1) << std::endl; // returns -1 (not found)
    std::cout << cache.get(3) << std::endl; // returns 3
    std::cout << cache.get(4) << std::endl; // returns 4
    return 0;
}
