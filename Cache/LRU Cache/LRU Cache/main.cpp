//
//  main.cpp
//  LRU Cache
//
//  Created by Andrei Ermoshin on 03/07/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

#include <iostream>
#include "LRUCache.hpp"

/**
 * Your LRUCache object will be instantiated and called as such:
 * LRUCache obj(capacity);
 * int param_1 = obj.get(key);
 * obj.put(key,value);
 */

int main(int argc, const char * argv[]) {
    LRUCache cache(2);
    cache.put(1, 1);
    cache.put(2, 2);
    std::cout << cache.get(1) << std::endl;
    cache.put(3, 3);
    std::cout << cache.get(2) << std::endl;
    cache.put(4, 4);
    std::cout << cache.get(1) << std::endl;
    std::cout << cache.get(3) << std::endl;
    std::cout << cache.get(4) << std::endl;
    return 0;
}
